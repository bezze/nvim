-- command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen 42
function bc (opts)
    -- vim.cmd { cmd = 'echo "' .. opts.fargs[1] .. '" | bc', bang = true }
    local obj = vim.system({
        'echo',
        '"' .. opts.fargs[1] .. '"',
        '| bc'
    }, { text = true }):wait()
    vim.cmd.echo (obj.stdout)
    -- vim.cmd.copen()
end

vim.api.nvim_create_user_command(
  'BC',
  bc,
  {bang = true, nargs = 1 }
)
