--local lspconfig = require('lspconfig')
return {
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = vim.lsp.util.find_git_ancestor,
    single_file_support = true,
}
