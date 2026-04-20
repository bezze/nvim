return {
    _on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<space>oi', function()
            vim.cmd("PyrightOrganizeImports")
        end, bufopts)
    end
}
