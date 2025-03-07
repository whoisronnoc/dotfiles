-- volar
return {
    -- add filetypes for typescript, javascript and vue
    filetypes = { "vue" },
    init_options = {
        vue = {
            -- disable hybrid mode
            hybridMode = false,
        },
        typescript = {
            -- replace with your global TypeScript library path
            tsdk = "/usr/local/lib/node_modules/typescript/lib",
        },
    },
    -- find a local one if not use a global if you cannot fine one
    on_new_config = function(new_config, new_root_dir)
        local lib_path =
            vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
        if lib_path then
            new_config.init_options.typescript.tsdk = lib_path
        end
    end,
}
