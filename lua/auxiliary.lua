vim.keymap.set('n', '<leader>m', function()
    lineText = vim.fn.getline('.')
    number = vim.fn.line('.')
    bufname = vim.fn.bufname('%')
    newItems = { {filename=bufname, lnum=number, text=lineText} }
    qflist = vim.fn.setqflist({}, 'a', {title='Marked', items=newItems})
    print('added line', number)
end, { expr = true, silent = true })
