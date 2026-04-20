return {
    -- cmd = { '/home/odysseus/Others/gits/scarb-git/target/release/scarb-cairo-language-server', '/C', '--node-ipc' },
    -- cmd = { 'scarb-cairo-language-server', '/C', '--node-ipc' },
    -- cmd = { "scarb", "cairo-language-server", "/C", "--node-ipc" },
    cmd = { "scarb", "cairo-language-server" },
    init_options = {
        hostInfo = "neovim"
    },
    filetypes = { 'cairo' },
}
