return {
    -- { "nvim-neo-tree/neo-tree.nvim",                 -- File Tree Browser
    -- 	branch = "v2.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" --[[ not strictly required, but recommended ]], "MunifTanjim/nui.nvim", } },
    { 'thaerkh/vim-indentguides' },                  -- Visual representation of indents
    { 'tpope/vim-commentary'     },                  -- Comment lines with gc
    { 'tpope/vim-fugitive'       },                  -- ? Git interface?
    { 'cloudhead/neovim-fuzzy'   },                  -- Fuzzy finder
    { 'tpope/vim-surround'       },                  -- Parentheses, brackets, quotes, XML tags, and more
    { 'bezze/delinhere'          },                  -- Handle bracket pairs
    -- Colorschemes {{{
    { 'sickill/vim-monokai'      },
    { 'savq/melange-nvim'        },
    --  Language extensions {{{
    -- JS
    { 'jelera/vim-javascript-syntax', ft = 'javascript.typescript' },
    -- TS
    { 'HerringtonDarkholme/yats.vim', ft = 'javascript.typescript' },
    -- language parser
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Markdown/github md previews
    { 'instant-markdown/vim-instant-markdown', ft = 'markdown', build = 'yarn install' },
    -- Terraform
    { 'hashivim/vim-terraform' },
    --  Language server {{{
    { 'neovim/nvim-lspconfig' },                                    -- Official native nvim lsp configuration
    -- Nvim Autocomplete
    { 'ms-jpq/coq_nvim', branch = 'coq', build = ':COQdeps' },
    -- COQ support for third party plugins, like GH copilot.
    { 'ms-jpq/coq.thirdparty' },
    -- 9000+ Snippets
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'mfussenegger/nvim-dap' },                                    -- Debugger
    -- Python extension (needs manual install, check github)
    { 'mfussenegger/nvim-dap-python', ft = 'python' },
    { 'mxsdev/nvim-dap-vscode-js', ft = 'javascript.typescript' },                                -- 
    -- AI {{{
    { 'github/copilot.vim' },                                       -- Github Copilot
    -- Navigation {{{
    { 'stevearc/aerial.nvim',                                         -- Code outline for quick navigation
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' } },
}
