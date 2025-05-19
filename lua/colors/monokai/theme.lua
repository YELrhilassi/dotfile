-- Base Vim highlighting groups
local c = require('colors.monokai.palette')
local util = require('colors.monokai.util')

local M = {}

M.base = {
  -- Base editor colors
  Normal = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.bg_dark },
  FloatBorder = { fg = c.gray, bg = c.bg_dark },
  Bold = { bold = true },
  Italic = { italic = true },
  Cursor = { bg = c.fg, fg = c.bg },
  CursorIM = { link = "Cursor" },
  CursorLine = { bg = c.bg_light },
  CursorColumn = { link = "CursorLine" },
  LineNr = { fg = c.gray_dark },
  CursorLineNr = { fg = c.orange, bold = true },
  EndOfBuffer = { fg = c.gray_dark },
  VertSplit = { fg = c.gray_dark },
  WinSeparator = { fg = c.gray_dark },
  FoldColumn = { fg = c.gray },
  SignColumn = { bg = c.bg },
  NonText = { fg = c.invisibles },
  SpecialKey = { fg = c.invisibles },
  Whitespace = { fg = c.invisibles },
  IncSearch = { bg = c.orange, fg = c.bg },
  Search = { bg = c.selection, fg = c.fg },
  Substitute = { bg = c.orange, fg = c.bg },
  Visual = { bg = c.selection },
  VisualNOS = { link = "Visual" },
  Folded = { fg = c.gray, bg = c.bg_light },
  ColorColumn = { bg = c.bg_light },
  
  -- Popup menu
  Pmenu = { fg = c.fg, bg = c.bg_dark },
  PmenuSel = { fg = c.bg, bg = c.blue },
  PmenuSbar = { bg = c.bg_light },
  PmenuThumb = { bg = c.gray },
  
  -- Status line
  StatusLine = { fg = c.fg, bg = c.bg_light },
  StatusLineNC = { fg = c.gray, bg = c.bg_light },
  
  -- Tab line
  TabLine = { fg = c.gray, bg = c.bg_dark },
  TabLineFill = { fg = c.gray, bg = c.bg_dark },
  TabLineSel = { fg = c.fg, bg = c.bg },
  
  -- Diagnostics
  DiagnosticError = { fg = c.error },
  DiagnosticWarn = { fg = c.warning },
  DiagnosticInfo = { fg = c.info },
  DiagnosticHint = { fg = c.hint },
  DiagnosticUnderlineError = { sp = c.error, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c.warning, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
  DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
  DiagnosticVirtualTextError = { fg = c.error, bg = util.highlight("", { fg = c.error, bg = c.bg }).bg },
  DiagnosticVirtualTextWarn = { fg = c.warning, bg = util.highlight("", { fg = c.warning, bg = c.bg }).bg },
  DiagnosticVirtualTextInfo = { fg = c.info, bg = util.highlight("", { fg = c.info, bg = c.bg }).bg },
  DiagnosticVirtualTextHint = { fg = c.hint, bg = util.highlight("", { fg = c.hint, bg = c.bg }).bg },
  
  -- Diffs
  DiffAdd = { fg = c.green_light, bg = util.highlight("", { fg = c.green_light, bg = c.bg }).bg },
  DiffChange = { fg = c.orange, bg = util.highlight("", { fg = c.orange, bg = c.bg }).bg },
  DiffDelete = { fg = c.red, bg = util.highlight("", { fg = c.red, bg = c.bg }).bg },
  DiffText = { fg = c.blue, bg = util.highlight("", { fg = c.blue, bg = c.bg }).bg },
  
  -- Spelling
  SpellBad = { sp = c.error, undercurl = true },
  SpellCap = { sp = c.warning, undercurl = true },
  SpellRare = { sp = c.purple, undercurl = true },
  SpellLocal = { sp = c.info, undercurl = true },
  
  -- Messages
  ErrorMsg = { fg = c.error },
  WarningMsg = { fg = c.warning },
  MoreMsg = { fg = c.green_light },
  Question = { fg = c.green_light },
  Directory = { fg = c.blue },
  Title = { fg = c.blue, bold = true },
  
  -- Misc
  MatchParen = { fg = c.fg, bg = c.selection, bold = true },
  WildMenu = { fg = c.fg, bg = c.blue },
  Conceal = { fg = c.gray },
  QuickFixLine = { bg = c.bg_light, bold = true },
  
  -- Common syntax elements
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.purple },
  String = { fg = c.string },
  Character = { fg = c.string },
  Number = { fg = c.number },
  Boolean = { fg = c.purple },
  Float = { fg = c.number },
  Identifier = { fg = c.fg },
  Function = { fg = c.green_light },
  Statement = { fg = c.pink },
  Conditional = { fg = c.pink },
  Repeat = { fg = c.pink },
  Label = { fg = c.orange },
  Operator = { fg = c.pink },
  Keyword = { fg = c.pink },
  Exception = { fg = c.pink },
  PreProc = { fg = c.pink },
  Include = { fg = c.pink },
  Define = { fg = c.pink },
  Macro = { fg = c.pink },
  PreCondit = { fg = c.pink },
  Type = { fg = c.blue },
  StorageClass = { fg = c.orange },
  Structure = { fg = c.pink },
  Typedef = { fg = c.blue },
  Special = { fg = c.purple_light },
  SpecialChar = { fg = c.pink },
  Tag = { fg = c.pink },
  Delimiter = { fg = c.fg },
  SpecialComment = { fg = c.comment, italic = true },
  Debug = { fg = c.orange },
  Underlined = { underline = true },
  Error = { fg = c.error },
  Todo = { fg = c.bg, bg = c.blue_light, bold = true },
  
  -- LSP References
  LspReferenceText = { bg = c.selection },
  LspReferenceRead = { bg = c.selection },
  LspReferenceWrite = { bg = c.selection },
  
  -- For native LSP
  LspSignatureActiveParameter = { fg = c.orange },
  LspCodeLens = { fg = c.gray },
  
  -- Neovim's built-in terminal
  Terminal = { fg = c.fg, bg = c.bg },
  TermCursor = { link = "Cursor" },
  TermCursorNC = { fg = c.fg, bg = c.gray },
}

-- Additional highlighting groups and overrides
function M.extend(highlights)
  return vim.tbl_deep_extend("force", highlights, {
    -- Add any overrides here
  })
end

return M
