-- Plugin-specific highlighting definitions
local M = {}

-- Import all plugin highlight configurations
M.load = function()
  return vim.tbl_deep_extend("force",
    require('colors.monokai.plugins.nvimtree'),
    require('colors.monokai.plugins.bufferline'),
    require('colors.monokai.plugins.lualine'),
    require('colors.monokai.plugins.notify'),
    require('colors.monokai.plugins.rainbow'),
    require('colors.monokai.plugins.treesitter')
  )
end

return M
