local M = {}

function M.copy_visual_range()
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  local s_line, s_col = s[2], s[3]
  local e_line, e_col = e[2], e[3]

  if s_line > e_line or (s_line == e_line and s_col > e_col) then
    s_line, e_line = e_line, s_line
    s_col, e_col = e_col, s_col
  end

  -- local bufname = vim.api.nvim_buf_get_name(0)
  local bufname = vim.fn.bufname('%')
  local str = string.format("%s:%d:%d-%d:%d", bufname, s_line, s_col, e_line, e_col)
  vim.fn.setreg("+", str)
  vim.notify(str)
end

return M
