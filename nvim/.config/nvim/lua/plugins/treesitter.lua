return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Or whatever build command is recommended
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "elixir", "javascript", "html", "python", "typescript"
            },
            auto_install = false,
            ignore_install = {},
            modules = {},
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = false },
        })
    end
}
