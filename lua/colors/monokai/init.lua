local M = {}

function M.setup(opts)
  -- Clear existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  -- Set terminal colors
  vim.o.termguicolors = true
  vim.g.colors_name = "monokai-soda"
  
  -- Process options
  opts = opts or {}
  
  -- Set transparent background if specified
  if opts.transparent_background then
    require('colors.monokai.util').set_transparent(true)
  end
  
  -- Load all highlight modules
  local util = require('colors.monokai.util')
  local highlights = util.generate_highlights(
    require('colors.monokai.theme').base,
    require('colors.monokai.plugins').load()
  )
  
  -- Apply highlights
  for group, hl in pairs(highlights) do
    if type(hl) == "table" then
      vim.api.nvim_set_hl(0, group, hl)
    else
      vim.notify(string.format("Invalid highlight for %s", group), vim.log.levels.WARN)
    end
  end
  
  -- Apply any additional customizations from the user
  if opts.overrides and type(opts.overrides) == "table" then
    for group, hl in pairs(opts.overrides) do
      if type(hl) == "table" then
        vim.api.nvim_set_hl(0, group, hl)
      else
        vim.notify(string.format("Invalid override for %s", group), vim.log.levels.WARN)
      end
    end
  end
end

return M
