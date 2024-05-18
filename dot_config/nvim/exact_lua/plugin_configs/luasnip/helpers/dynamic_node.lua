local ls = require("luasnip")
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

local function find_dynamic_node(node)
	-- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
	-- actual use is to refer to the dynamicNode that generated the snippet).
	while not node.dynamicNode do
		if node.parent == nil then
			return nil
		end
		node = node.parent
	end
	return node.dynamicNode
end

local M = {}

local external_update_id = 0
-- func_indx to update the dynamicNode with different functions.
M.external_update = function(func_key)
	-- most of this function is about restoring the cursor to the correct
	-- position+mode, the important part are the few lines from
	-- `dynamic_node.snip:store()`.

	-- find current node and the innermost dynamicNode it is inside.
	local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
	if current_node == nil then
		print("Not within a luasnip node.")
		return
	end

	local dynamic_node = find_dynamic_node(current_node)
	if dynamic_node == nil then
		print("No dynamic node found.")
		return
	end

	-- to identify current node in new snippet, if it is available.
	external_update_id = external_update_id + 1
	current_node.external_update_id = external_update_id
	local current_node_key = current_node.key

	-- store which mode we're in to restore later.
	local insert_pre_call = vim.fn.mode() == "i"
	-- is byte-indexed! Doesn't matter here, but important to be aware of.
	local cursor_pos_end_relative = util.pos_sub(util.get_cursor_0ind(), current_node.mark:get_endpoint(1))

	-- leave current generated snippet.
	node_util.leave_nodes_between(dynamic_node.snip, current_node)

	local dynamic_funcs = dynamic_node.user_args["dynamic_funcs"]
	if type(dynamic_funcs) ~= "table" then
		print('user_args["dynamic_funcs"] must be set to a table of functions')
		return
	end

	-- call update-function.
	local func = dynamic_funcs[func_key]
	if func then
		if type(func) ~= "function" then
			print("Key does not point to a function: " .. func_key)
			return
		end
		-- the same snippet passed to the dynamicNode-function. Any output from func
		-- should be stored in it under some unused key.
		func(dynamic_node.parent.snippet)
	else
		print("Key not found in function table: " .. func_key)
		return
	end

	-- last_args is used to store the last args that were used to generate the
	-- snippet. If this function is called, these will most probably not have
	-- changed, so they are set to nil, which will force an update.
	dynamic_node.last_args = nil
	dynamic_node:update()

	-- everything below here isn't strictly necessary, but it's pretty nice to have.

	-- try to find the node we marked earlier, or a node with the same key.
	-- Both are getting equal priority here, it might make sense to give "exact
	-- same node" higher priority by doing two searches (but that would require
	-- two searches :( )
	local target_node = dynamic_node:find_node(function(test_node)
		return (test_node.external_update_id == external_update_id)
			or (current_node_key ~= nil and test_node.key == current_node_key)
	end)

	if target_node then
		-- the node that the cursor was in when changeChoice was called exists
		-- in the active choice! Enter it and all nodes between it and this choiceNode,
		-- then set the cursor.
		node_util.enter_nodes_between(dynamic_node, target_node)

		if insert_pre_call then
			-- restore cursor-position if the node, or a corresponding node,
			-- could be found.
			-- It is restored relative to the end of the node (as opposed to the
			-- beginning). This does not matter if the text in the node is
			-- unchanged, but if the length changed, we may move the cursor
			-- relative to its immediate neighboring characters.
			-- I assume that it is more likely that the text before the cursor
			-- got longer (since it is very likely that the cursor is just at
			-- the end of the node), and thus restoring relative to the
			-- beginning would shift the cursor back.
			--
			-- However, restoring to any fixed endpoint is likely to not be
			-- perfect, an interesting enhancement would be to compare the new
			-- and old text/[neighborhood of the cursor], and find its new position
			-- based on that.
			util.set_cursor_0ind(util.pos_add(target_node.mark:get_endpoint(1), cursor_pos_end_relative))
		else
			node_util.select_node(target_node)
		end
		-- set the new current node correctly.
		ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
	else
		-- the marked node wasn't found, just jump into the new snippet noremally.
		ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
	end
end

return M
