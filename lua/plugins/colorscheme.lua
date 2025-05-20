return {
  name = "monokai",
  dir = vim.fn.stdpath("config") .. "/lua/colors/monokai",
  lazy = false,
  priority = 1000,
  config = function()
    require("colors.monokai").setup(
      {
        transparent_background = false, -- Set to true for transparent background


        overrides = {}
      }
    )
  end,
}
