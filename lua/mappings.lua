-- neovim-fuzzy
vim.keymap.set('n', '<C-P>', function () vim.cmd("FuzzyOpen .") end)

local _border = "rounded"

-- lsp mappings
local lspconfig = require('lspconfig')

require('lspconfig.ui.windows').default_options = {
  border = _border
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>oi', function()
        vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

end  -- end on_attach

-- Automatically start coq
-- vim.g.coq_settings = { auto_start = 'shut-up' }

-- COQ 3rd party
require("coq_3p") {
  { src = "copilot", short_name = "COP", tmp_accept_key = "<c-r>", accept_key = "<c-f>" }  -- github copilot
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = { 'tsserver', 'rust_analyzer' }

-- vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>]]
-- vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>]]
-- vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>]]

-- local _border = "single"
-- local _border = { '╔', '═' ,'╗', '║', '╝', '═', '╚', '║' }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
        on_attach = on_attach,
        flags = lsp_flags,
        handlers = {
            ["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = _border }
            ),
            ["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = _border }
            )
        }
    }))
end

-- only disable highlights for pylsp
lspconfig.pylsp.setup(require('coq').lsp_ensure_capabilities({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentHighlightProvider = false
        on_attach(client, bufnr)
    end
}))

-- Aerial
require('aerial').setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '<Leader>{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '<Leader>}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
-- vim.keymap.set('n', '~', require('aerial').open)


