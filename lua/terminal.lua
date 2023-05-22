
local function get_interpreter(debug)
    fileext = vim.fn.expand('%:e')
    local extmap = {
        js = 'node',
        cjs = 'node',
        ts = 'ts-node',
        py = 'python3',
        sh = 'sh',
        bash = 'bash',
        lua = 'lua',
    }
    if debug then
        extmap = {
            js = 'node inspect',
            cjs = 'node inspect',
            py = 'python3',
        }
    end
    if fileext == 'py' and not vim.fn.empty(vim.env.VIRTUAL_ENV) then
        return vim.env.VIRTUAL_ENV .. '/bin/' .. extmap[fileext]
    end
    return extmap[fileext]
end

function Interpreter(opts)
    local opts = opts or {}
    local debug = opts.debug or false
    local run = opts.run or false
    interpreter = get_interpreter(debug)
    vim.cmd(':7split')
    if run then
        vim.cmd(':terminal ' .. interpreter .. ' ' ..  vim.fn.expand('%'))
    else
        vim.cmd(':terminal ' .. interpreter)
    end
end

vim.keymap.set('n', '<Leader>T',  ':tabnew<CR>:terminal<CR>')
vim.keymap.set('n',  '<Leader>t', ':7split<CR>:terminal<CR>')
-- vim.keymap.set('n',  '<Esc>', [[<C-\><C-n>]]) -- tnoremap <Esc> <C-\><C-n>
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]] -- tnoremap <Esc> <C-\><C-n>

vim.keymap.set('n',  '<Leader>p', Interpreter)
vim.keymap.set('n',  '<Leader>r', function() Interpreter({ run = true }) end)
vim.keymap.set('n',  '<Leader>R', function() Interpreter({ debug = true, run = true }) end)
