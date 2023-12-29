return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("treesitter-context").setup({
      enable = true,
    })
  end,
}
