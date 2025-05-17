local palette = require("colors.monokai.palette")
local util = require("colors.monokai.util")

return {
  Normal       = { fg = palette.fg, bg = palette.bg },
  NormalFloat  = { fg = palette.fg, bg = palette.bg_alt },

  Comment      = { fg = palette.comment, italic = true },
  LineNr       = { fg = palette.comment },
  CursorLine   = { bg = palette.current_line },
  CursorLineNr = { fg = palette.tree_poppy, bold = true },
  Visual       = { bg = palette.selection },
  Search       = { fg = palette.bg, bg = palette.tree_poppy },
  IncSearch    = { fg = palette.bg, bg = palette.pear },
  
  -- Syntax groups
  String       = { fg = palette.string },
  Number       = { fg = palette.number },
  Boolean      = { fg = palette.fuchsia },
  Function     = { fg = palette.pear },
  Identifier   = { fg = palette.malibu },
  Keyword      = { fg = palette.radical_red },
  PreProc      = { fg = palette.spray },
  Type         = { fg = palette.atlantis },
  Operator       = { fg = palette.pink },
  Delimiter      = { fg = palette.gold },  -- For most brackets
  Special        = { fg = palette.gold_alt }, -- Alternate for some brackets
  
  -- UI
  StatusLine   = { fg = palette.fg, bg = palette.current_line },
  VertSplit    = { fg = palette.border },
  Pmenu        = { fg = palette.fg, bg = palette.current_line },
  PmenuSel     = { fg = palette.bg, bg = palette.spray },

  -- Borders and UI elements
  FloatBorder    = { fg = palette.subtle_border },
  WinSeparator   = { fg = palette.subtle_border, bg = palette.bg },
  VertSplit      = { fg = palette.subtle_border },
  NvimTreeWinSeparator = { fg = palette.subtle_border },
  
  -- Diff
  DiffAdd      = { fg = palette.atlantis },
  DiffChange   = { fg = palette.tree_poppy },
  DiffDelete   = { fg = palette.radical_red },
  DiffText     = { fg = palette.pear },
  
  -- Others
  ErrorMsg     = { fg = palette.thunderbird },
  WarningMsg   = { fg = palette.tree_poppy },
  Todo         = { fg = palette.bg, bg = palette.pear, bold = true }
}

