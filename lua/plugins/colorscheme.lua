return {
  name = "monokai",
  dir = vim.fn.stdpath("config") .. "/lua/colors/monokai",
  lazy = false,
  priority = 1000,
  config = function ()
    require("colors.monokai").load()
  end,
}
