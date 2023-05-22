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
    --  Language extensions {{{
    { 'jelera/vim-javascript-syntax',                  -- JS
       ft = 'javascript.typescript' },
    { 'HerringtonDarkholme/yats.vim',                   -- TS
       ft = 'javascript.typescript' },
    { 'nvim-treesitter/nvim-treesitter',                -- language parser
        build = ':TSUpdate' },
    { 'instant-markdown/vim-instant-markdown',          -- Markdown/github md previews
        ft = 'markdown', build = 'yarn install' },
    --  Language server {{{
    { 'neovim/nvim-lspconfig' },                                    -- Official native nvim lsp configuration
    { 'ms-jpq/coq_nvim',                                            -- Nvim Autocomplete
        branch = 'coq', build = ':COQdeps' },
    { 'ms-jpq/coq.artifacts',                                       -- 9000+ Snippets
        branch = 'artifacts' },
    { 'mfussenegger/nvim-dap' },                                    -- Debugger
    { 'mfussenegger/nvim-dap-python',                                -- Python extension (needs manual install, check github)
       ft = 'python' },
    { 'mxsdev/nvim-dap-vscode-js',
       ft = 'javascript.typescript' },                                -- 
    -- Navigation {{{
    { 'stevearc/aerial.nvim',                                         -- Code outline for quick navigation
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' } },
}
