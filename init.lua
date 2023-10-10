-- " Leader
vim.g.mapleader = ' '           -- let mapleader = "\<Space>"
vim.g.hlsearch = true
vim.g.coq_settings = { auto_start = 'shut-up' }
vim.opt.termguicolors = true
-- For some reason this doesnt work
-- vim.g.grepprg = 'rg --vimgrep --smart-case --follow'           -- set grepprg=rg\ --vimgrep\ --smart-case\ --follow
vim.cmd [[ set grepprg=rg\ --vimgrep\ --smart-case\ --follow ]]
vim.cmd [[ set mouse= ]]

-- Plugin bootloader {{{1
  -- # Automatically git clone when `lazypath` not found
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "--depth=1",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
  require("lazy").setup("plugins")

-- Plugin mappings {{{1
require("mappings")
-- Plugin custom settings {{{1
require("settings")
-- Plugin auxiliary custom functions {{{1
require("auxiliary")
-- Coloscheme {{{1
--vim.cmd.colorscheme("habamax")
-- vim.cmd.colorscheme("melange")
vim.cmd.colorscheme("monokai")


-- Config {{{1
-- Options {{{2
-- syntax on
-- filetype plugin indent on
-- highlight ColorColumn ctermbg=235 guibg=#2c2d27

vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true   -- set relativenumber
vim.opt.number = true           -- set number
vim.opt.wrap = false            -- set nowrap
vim.opt.expandtab = true        -- set expandtab
vim.opt.tabstop = 4             -- set tabstop=4
vim.opt.shiftwidth = 4          -- set shiftwidth=4
vim.opt.textwidth = 0           -- set textwidth=0
vim.opt.wrapmargin = 0          -- set wrapmargin=0
vim.opt.cursorline = true       -- set cursorline  " shows line under the cursor's line
-- " highlight CursorLine ctermbg=135 guibg=#5c2d27

-- " Enable folding
vim.opt.foldmethod = 'syntax' -- set foldmethod=indent

-- " Start unfolded
vim.opt.foldlevelstart = 99 -- set foldlevelstart=99

vim.opt.previewheight = 60       -- set previewheight=60

-- Mappings {{{2

-- "Deactivates hl for searches
vim.keymap.set('n', '<Esc><Esc>', function() vim.cmd [[ nohlsearch ]] end) -- nnoremap <Esc><Esc> :nohlsearch<CR><CR>

-- " Allow saving of files as sudo when I forgot to start vim using sudo.
-- cmap w!! w !sudo tee > /dev/null %

-- " Smart Home
vim.keymap.set('n', '<Home>', function()
    cond = vim.fn.col('.') == vim.fn.match(vim.fn.getline('.'), [[\S]])+1
    if cond then return '0' else return '^' end
end, { expr = true, silent = true }) -- noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

-- imap <silent> <Home> <C-O><Home>
-- " Save and suspend
-- :noremap <C-Z> :w<CR><C-z> 
-- " End of line and enter
-- :noremap s $A<CR><Esc>


-- " Open tag in vsplit
--vim.keymap.set('n', '<C-]>', function()
--    vim.cmd.vertical(
--        vim.cmd.ptag(
--            vim.fn.expand("<cword>")
--        )
--    )
--end) -- " nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>

-- " binds 'shift tab' to 'toggle fold'
vim.keymap.set('n', '<S-Tab>', 'za') -- nnoremap <s-tab> za

vim.keymap.set('n', '<Leader>k', vim.cmd.tabnext)  -- nnoremap <Leader>k :tabnext<CR>
vim.keymap.set('n', '<Leader>j', vim.cmd.tabprev)  -- nnoremap <Leader>j :tabprev<CR>
vim.keymap.set('n', '<Leader>l', vim.cmd.tablast)  -- nnoremap <Leader>l :tablast<CR>
vim.keymap.set('n', '<Leader>h', vim.cmd.tabfirst)  -- nnoremap <Leader>h :tabfirst<CR>
vim.keymap.set('n', '<Leader>n', function ()
    return ':tabnew '
    -- return ':lua vim.cmd.tabnew("")<Left><Left>'
end, { expr = true })  -- nnoremap <Leader>n :tabnew<space>

-- " Window commands
vim.keymap.set('n', '<C-C>', vim.cmd.close) -- nmap <C-C> <C-W>c
vim.keymap.set('n', '<C-j>', function () vim.cmd.wincmd('j') end)
vim.keymap.set('n', '<C-k>', function () vim.cmd.wincmd('k') end)
vim.keymap.set('n', '<C-l>', function () vim.cmd.wincmd('l') end)
vim.keymap.set('n', '<C-n>', function () vim.cmd.wincmd('h') end)

-- " Horizontal scrolling
vim.keymap.set({'n', 'i'}, '<M-k>', 'zl')
vim.keymap.set({'n', 'i'}, '<M-l>', '20zl')
vim.keymap.set({'n', 'i'}, '<M-j>', 'zh')
vim.keymap.set({'n', 'i'}, '<M-h>', '20zh')

-- " Explorer
vim.keymap.set('n', '<Leader><Tab>', vim.cmd.Lexplore)

-- Terminal {{{3
require('terminal')
--}}}

-- command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen 42
function NewGrep (opts)
    vim.cmd.grep { opts.fargs[1], bang = true }
    vim.cmd.copen()
end

vim.api.nvim_create_user_command(
  'NewGrep',
  NewGrep,
  {bang = true, nargs = 1 }
)

vim.keymap.set('n', '<Leader>g', function () return ':NewGrep ' end, { expr = true })

-- Autocommands {{{2
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.lua"},
  callback = function()
    vim.opt_local.foldlevelstart = 0
    vim.opt_local.foldmethod = 'marker'
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.ts", "*.js", "*.cjs", "*.mjs"},
    callback = function()
        require("langs/typescript")
    end,
})

-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--     pattern = {"*.ts"},
--     callback = function()
--         vim.cmd [[ :!prettier --write % ]]
--     end,
-- })

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.py"},
    callback = function()
        require("langs/python")
    end,
})

vim.api.nvim_create_autocmd({"TermOpen"}, {
    callback = function() vim.cmd.startinsert() end,
})

-- }}}
