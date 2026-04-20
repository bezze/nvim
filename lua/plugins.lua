return {

    -- { "nvim-neo-tree/neo-tree.nvim",                 -- File Tree Browser
    -- 	branch = "v2.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" --[[ not strictly required, but recommended ]], "MunifTanjim/nui.nvim", } },
    -- { 'thaerkh/vim-indentguides' },                  -- Visual representation of indents
    { 'tpope/vim-commentary'     },                  -- Comment lines with gc
    { 'tpope/vim-fugitive'       },                  -- ? Git interface?
    { 'cloudhead/neovim-fuzzy'   },                  -- Fuzzy finder
    { 'tpope/vim-surround'       },                  -- Parentheses, brackets, quotes, XML tags, and more
    { 'junegunn/vim-easy-align'  },                  -- To automatically align characters
    { 'bezze/delinhere'          },                  -- Handle bracket pairs
    -- Colorschemes {{{
    { 'sickill/vim-monokai'      },
    { 'savq/melange-nvim'        },
    { 'mhartington/oceanic-next' },
    { 'jacoborus/tender.vim' },
    { 'rebelot/kanagawa.nvim' },
    --  Language extensions {{{
    -- JS
    { 'jelera/vim-javascript-syntax', ft = 'javascript.typescript' },
    -- TS
    { 'HerringtonDarkholme/yats.vim', ft = 'javascript.typescript' },
    -- language parser
    {
        'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            branch = "main",
            opts = {
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            },
    },
    -- Markdown/github md previews
    -- { 'instant-markdown/vim-instant-markdown', ft = 'markdown', build = 'yarn install' },
    -- GraphQL
    { 'jparise/vim-graphql' },
    -- Solidity
    { 'tomlion/vim-solidity' },
    -- Terraform
    { 'hashivim/vim-terraform' },
    -- Prisma
    { 'pantharshit00/vim-prisma' },
    -- Circom
    { 'iden3/vim-circom-syntax' },
    { 'miguelmota/cairo.vim' },
    --  Language server {{{
    { 'neovim/nvim-lspconfig' },                                    -- Official native nvim lsp configuration
    { 'lbrayner/vim-rzip' },  -- required to support Yarn4 PnP
    -- latex
    {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
      end
    },
    -- Nvim Autocomplete
    { 'ms-jpq/coq_nvim', branch = 'coq', build = ':COQdeps' },
    -- COQ support for third party plugins, like GH copilot.
    { 'ms-jpq/coq.thirdparty' },
    -- 9000+ Snippets
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'mfussenegger/nvim-lint' },                                   -- Linter integration
    { 'mfussenegger/nvim-dap' },                                    -- Debugger
    -- Python extension (needs manual install, check github)
    { 'mfussenegger/nvim-dap-python', ft = 'python' },
    { 'mxsdev/nvim-dap-vscode-js', ft = 'javascript.typescript' },                                -- 
    -- AI {{{
    -- { 'github/copilot.vim' },                                       -- Github Copilot
    -- Navigation {{{
    { 'stevearc/aerial.nvim',                                         -- Code outline for quick navigation
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter' } },
    { name = 'vim-psql', dir = vim.fn.stdpath("data") .. '/plugged/vim-psql' },
    { 'pwntester/octo.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
        -- OR 'nvim-telescope/telescope.nvim',
        -- OR 'folke/snacks.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()
        require"octo".setup({
            picker = "fzf-lua"
        })
    end
    }
}
