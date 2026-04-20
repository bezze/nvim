-- function merge(t1, t2) 
--     t3 = {}
--     for k, v in pairs(t1) do t3[k] = v end
--     for k, v in pairs(t2) do t3[k] = v end
--     return t3
-- end




-- neovim-fuzzy
vim.keymap.set('n', '<C-P>', function () vim.cmd("FuzzyOpen .") end)

local _border = "rounded"

---- lsp mappings
--local lspconfig = vim.lsp.config("*")
--
--lspconfig.ui.windows.default_options = {
--  border = _border
--}

vim.keymap.set('n', '<leader>1', function () vim.cmd("G") end)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_common = function(client, bufnr)
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
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  -- vim.keymap.set('n', '<space>oi', function()
  --       vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
  -- end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- vim.keymap.set('n', '<space>f', function() vim.api.nvim_command(':! prettier -w ' .. vim.api.nvim_buf_get_name(0)) end, bufopts)
  vim.keymap.set('n', '<leader>L', function() require('lint').try_lint() end, bufopts)
end  -- end on_attach

-- COQ 3rd party (commented because part of main now)
-- require("coq_3p") {
--   { src = "copilot", short_name = "COP", tmp_accept_key = "<c-r>", accept_key = "<c-f>" }  -- github copilot
-- }

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = {
    { name = 'ts_ls', config = require("lsp_config/ts_ls") },
    { name = 'denols', config = require("lsp_config/deno") },
    { name = 'rust_analyzer' },
    -- { name = 'angularls' },
    { name = 'ruff' },
    { name = 'bashls' },
    { name = 'basedpyright', config = require("lsp_config/basedpyright") },
    { name = 'solidity', config = require("lsp_config/solidity") },
    { name = 'ccls', config = require("lsp_config/ccls") },
    -- { name = 'cairo_ls' },
    { name = 'cairo_ls', config = require("lsp_config/cairo_ls") },
    { name = 'yamlls', config = require("lsp_config/yamlls") },
    { name = 'html', config = require("lsp_config/html") }
}

-- vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>]]
-- vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>]]
-- vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>]]

-- local _border = "single"
-- local _border = { '╔', '═' ,'╗', '║', '╝', '═', '╚', '║' }

for _, srv in ipairs(servers) do

    -- if exists, we wrap per-server _on_attach with global on_attach
    if srv.config and srv.config._on_attach then
        on_attach_agg = function (client, bufnr)
            on_attach_common(client, bufnr)
            srv.config._on_attach(client, bufnr)
        end
    else
        on_attach_agg = on_attach_common
    end

    -- we define the common server config, using aggregated on-attach
    local common_srv_config = {
        on_attach = on_attach_agg,
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
    }
    -- if server has custom config, we extend common_srv_config with srv.config
    if srv.config then
        common_srv_config = vim.tbl_extend('force', common_srv_config, srv.config)
    end
    vim.lsp.config(srv.name, require('coq').lsp_ensure_capabilities(common_srv_config))
    vim.lsp.enable(srv.name)

end

-- -- only disable highlights for pylsp
-- lspconfig.pylsp.setup(require('coq').lsp_ensure_capabilities({
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentHighlightProvider = false
--         on_attach(client, bufnr)
--     end
-- }))

-- lspconfig.basedpyright.setup(require('coq').lsp_ensure_capabilities({
--     on_attach = function(client, bufnr)
--         vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
--         vim.
--         on_attach(client, bufnr)
--     end
-- }))
-- PyrightSetPythonPath


-- WARNING: Commands is deprecated and will be removed in future releases.
-- It is recommended to use `vim.api.nvim_create_user_command()` instead in an
-- |LspAttach| autocommand handler.

-- Example:
-- >lua
--   local function organize_imports()
--     local params = {
--       command = 'pyright.organizeimports',
--       arguments = { vim.uri_from_bufnr(0) },
--     }
--     vim.lsp.buf.execute_command(params)
--   end

--   vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(ev)
--       local client = vim.lsp.get_client_by_id(ev.data.client_id)
--       if client.name == "pyright" then
--         vim.api.nvim_create_user_command("PyrightOrganizeImports", organize_imports, {desc = 'Organize Imports'})
--       end
--     end
--   end

--   lspconfig['pyright'].setup{}



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

vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)') -- { noremap = true, silent = true })
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)') -- { noremap = true, silent = true })

vim.keymap.set("x", "<leader>yr", function() require("extensions.copy_range").copy_visual_range() end)

