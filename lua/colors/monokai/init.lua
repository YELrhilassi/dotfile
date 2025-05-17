local M = {}

function M.load()
  vim.cmd("highlight clear")
  vim.o.termguicolors = true
  vim.g.colors_name = "monokai"

  local theme = require("colors.monokai.theme")
  local semantic = require("colors.monokai.semantic")
  local plugins = require("colors.monokai.plugins")

  for group, hl in pairs(vim.tbl_deep_extend("force", theme, semantic, plugins)) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

return M
