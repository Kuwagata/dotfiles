local M = {}

M.startswith = function(s, prefix)
  return string.sub(s, 1, #prefix) == prefix
end

return M
