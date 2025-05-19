return{
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 4,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil, -- no border/line between context and code
    })
  end,
}
