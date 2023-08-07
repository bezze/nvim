vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.cmd [[noremap ;p iconsole.log()<Esc>i]]   -- noremap ;p iconsole.log()<Esc>i
vim.cmd [[inoremap ;p console.log()<Esc>i]]   -- inoremap ;p console.log()<Esc>i
vim.cmd [[nnoremap ;o i;(async () =>{<CR>})()<Esc>O]]   -- inoremap ;p console.log()<Esc>i

-- vim.keymap.set({'n', 'i'}, ';p', function ()
--     -- vim.api.nvim_feedkeys('iconsole.log()<Esc>i', 'n', true)
--     relevant = [[ console.log()<Esc>i ]]
--         vim.cmd [['i' .. relevant ]]
-- end)

function getTsBuildErrors(file)
    -- src/index.ts(11,1): error TS2304: Cannot find name 'hola'.
    meta = {
        title='ts-errors-3',
        context='ts-errors-3'
    }
    vim.fn.setqflist({}, 'r', meta)     -- clear quickfix
    vim.fn.setqflist({}, 'a', {
        efm=[[%f(%l\,%c): %trror TS%n: %m]],  -- XXX: we *need* to escape comma because efm is a comma serparated list
        lines=vim.fn.systemlist("rg --text 'error TS' " .. file),
        title=meta.title,
        context=meta.context
    })
    vim.cmd [[:copen]]
end


vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.ts"},
    callback = function()
        vim.keymap.set('n', '<Leader>E', function ()
            getTsBuildErrors('/tmp/build.errors')
        end, { buffer = true })
    end,
})

