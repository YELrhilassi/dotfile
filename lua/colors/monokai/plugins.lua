local palette = require("colors.monokai.palette")
local util = require("colors.monokai.util")


return  {
  -- Telescope
  TelescopeBorder         = { fg = palette.subtle_border },
  TelescopePromptBorder   = { fg = palette.subtle_border_alt },
  TelescopeSelection      = { bg = palette.selection },
  TelescopeMatching       = { fg = palette.tree_poppy },
  TelescopePromptNormal   = { fg = palette.fg, bg = palette.bg },
  TelescopePromptPrefix   = { fg = palette.magenta },

  -- GitSigns
  GitSignsAdd             = { fg = palette.atlantis },
  GitSignsChange          = { fg = palette.tree_poppy },
  GitSignsDelete          = { fg = palette.radical_red },

  -- Lualine
  StatusLine              = { fg = palette.fg, bg = palette.bg },
  StatusLineNC            = { fg = palette.gray, bg = palette.bg },

  -- Lazy.nvim
  LazyNormal              = { fg = palette.fg, bg = palette.bg },
  LazyDimmed              = { fg = palette.gray },
  LazyProp                = { fg = palette.blue },
  LazyH1                  = { fg = palette.bg, bg = palette.green, bold = true },
  LazyReasonCmd           = { fg = palette.yellow },
  LazyReasonEvent         = { fg = palette.magenta },
  LazyReasonFt            = { fg = palette.cyan },

  -- Which-key
  WhichKey                = { fg = palette.lavender },
  WhichKeyGroup           = { fg = palette.blue },
  WhichKeyDesc            = { fg = palette.pear },
  WhichKeySeparator       = { fg = palette.gray },
  WhichKeyFloat           = { bg = palette.bg },
  WhichKeyValue           = { fg = palette.fg },

  -- Noice / LSP UI
  NoiceCmdlinePopupBorder = { fg = palette.border },
  NoicePopup              = { fg = palette.fg, bg = palette.bg },

  -- Notify
  NotifyERRORBorder       = { fg = palette.red },
  NotifyWARNBorder        = { fg = palette.orange },
  NotifyINFOBorder        = { fg = palette.green },
  NotifyDEBUGBorder       = { fg = palette.gray },
  NotifyTRACEBorder       = { fg = palette.purple },
  NotifyERRORIcon         = { fg = palette.red },
  NotifyWARNIcon          = { fg = palette.orange },
  NotifyINFOIcon          = { fg = palette.green },
  NotifyDEBUGIcon         = { fg = palette.gray },
  NotifyTRACEIcon         = { fg = palette.purple },
  NotifyERRORTitle        = { fg = palette.red, bold = true },
  NotifyWARNTitle         = { fg = palette.orange, bold = true },
  NotifyINFOTitle         = { fg = palette.green, bold = true },
  NotifyDEBUGTitle        = { fg = palette.gray, bold = true },
  NotifyTRACETitle        = { fg = palette.purple, bold = true },

  -- Navic
  NavicText               = { fg = palette.gray },
  NavicSeparator          = { fg = palette.gray },
  NavicIconsFile          = { fg = palette.green },
  NavicIconsModule        = { fg = palette.cyan },
  NavicIconsNamespace     = { fg = palette.blue },
  NavicIconsClass         = { fg = palette.yellow },
  NavicIconsFunction      = { fg = palette.magenta },

  -- LSP Diagnostics
  DiagnosticError         = { fg = palette.thunderbird },
  DiagnosticWarn          = { fg = palette.tree_poppy },
  DiagnosticInfo          = { fg = palette.spray },
  DiagnosticHint          = { fg = palette.malibu },

  -- Mini.nvim
  MiniIndentscopeSymbol   = { fg = palette.gray },
  MiniStatuslineModeNormal = { bg = palette.green, fg = palette.bg, bold = true },
  MiniStatuslineModeInsert = { bg = palette.blue, fg = palette.bg, bold = true },
  MiniStatuslineModeVisual = { bg = palette.magenta, fg = palette.bg, bold = true },

  -- Treesitter Context
  TreesitterContext       = { bg = palette.bg_alt },
  TreesitterContextLineNumber = { fg = palette.orange },

  -- NvimTree (fallback)
  NvimTreeFolderIcon      = { fg = palette.spray },
  NvimTreeIndentMarker    = { fg = palette.border },
  NvimTreeNormal          = { bg = palette.bg },
  NvimTreeWinSeparator    = { fg = palette.subtle_border },

  -- Indent Blankline
  IndentBlanklineChar     = { fg = palette.current_line },

  -- Bufferline
  BufferLineBufferSelected = { fg = palette.fg, bg = palette.current_line, bold = true },
  BufferLineSeparator     = { fg = palette.subtle_border, bg = palette.bg },
  
  -- Neo-tree window
  NeoTreeNormal         = { fg = palette.fg, bg = palette.bg },
  NeoTreeNormalNC       = { fg = palette.fg, bg = palette.bg },
  NeoTreeEndOfBuffer    = { fg = palette.bg, bg = palette.bg },
  NeoTreeWinSeparator   = { fg = palette.subtle_border, bg = palette.bg },
  NeoTreeSignColumn     = { fg = palette.fg, bg = palette.bg },

  -- Cursor line
  NeoTreeCursorLine     = { bg = palette.selection },
  NeoTreeCursorLineSign = { bg = palette.selection },
  NeoTreeCursor         = { bg = palette.selection },

  -- Icons
  NeoTreeDirectoryIcon  = { fg = palette.gold },
  NeoTreeDirectoryName  = { fg = palette.fg },
  NeoTreeFileIcon       = { fg = palette.fg },
  NeoTreeFileName       = { fg = palette.fg },
  NeoTreeIndentMarker   = { fg = palette.subtle_border },
  NeoTreeExpander       = { fg = palette.fg },

  -- Git
  NeoTreeGitAdded       = { fg = palette.atlantis },
  NeoTreeGitDeleted     = { fg = palette.radical_red },
  NeoTreeGitModified    = { fg = palette.tree_poppy },
  NeoTreeGitUntracked   = { fg = palette.fuchsia },
  NeoTreeGitIgnored     = { fg = palette.comment },
  NeoTreeGitConflict    = { fg = palette.thunderbird },
  NeoTreeGitStaged      = { fg = palette.pear },
  NeoTreeGitRenamed     = { fg = palette.malibu },

  -- Tabs (optional)
  NeoTreeTabActive      = { fg = palette.fg, bg = palette.bg_alt, bold = true },
  NeoTreeTabInactive    = { fg = palette.comment, bg = palette.bg },
  NeoTreeTabSeparatorActive = { fg = palette.subtle_border, bg = palette.bg_alt },
  NeoTreeTabSeparatorInactive = { fg = palette.subtle_border, bg = palette.bg },

}




