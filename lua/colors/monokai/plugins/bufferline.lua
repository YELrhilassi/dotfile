-- Bufferline highlights
local c = require('colors.monokai.palette')

return {
  -- Bufferline tabs
  BufferLineFill = { bg = c.bg_dark },
  BufferLineBackground = { fg = c.gray, bg = c.bg_dark },
  BufferLineBufferVisible = { fg = c.gray_light, bg = c.bg_dark },
  BufferLineBufferSelected = { fg = c.fg, bg = c.bg, bold = true },
  
  -- Close buttons
  BufferLineCloseButton = { fg = c.gray, bg = c.bg_dark },
  BufferLineCloseButtonVisible = { fg = c.gray_light, bg = c.bg_dark },
  BufferLineCloseButtonSelected = { fg = c.red, bg = c.bg },
  
  -- Modified indicators
  BufferLineModified = { fg = c.orange, bg = c.bg_dark },
  BufferLineModifiedVisible = { fg = c.orange, bg = c.bg_dark },
  BufferLineModifiedSelected = { fg = c.green_light, bg = c.bg },
  
  -- Duplicate buffer indicators
  BufferLineDuplicate = { fg = c.gray, bg = c.bg_dark, italic = true },
  BufferLineDuplicateVisible = { fg = c.gray, bg = c.bg_dark, italic = true },
  BufferLineDuplicateSelected = { fg = c.gray_light, bg = c.bg, italic = true },
  
  -- Separators
  BufferLineSeparator = { fg = c.bg_dark, bg = c.bg_dark },
  BufferLineSeparatorVisible = { fg = c.bg_dark, bg = c.bg_dark },
  BufferLineSeparatorSelected = { fg = c.bg_dark, bg = c.bg_dark },
  
  -- Tab indicators
  BufferLineTab = { fg = c.gray, bg = c.bg_dark },
  BufferLineTabSelected = { fg = c.blue, bg = c.bg },
  BufferLineTabClose = { fg = c.red, bg = c.bg_dark },
  
  -- Indicators
  BufferLineIndicatorSelected = { fg = c.blue, bg = c.bg },
  
  -- Buffer line offset
  BufferLineOffsetSeparator = { fg = c.bg_light, bg = c.bg_dark },
  
  -- Buffer line groups
  BufferLineGroupSeparator = { fg = c.gray, bg = c.bg_dark },
  BufferLineGroupLabel = { fg = c.bg, bg = c.blue },
  
  -- Buffer line diagnostic icons
  BufferLineDiagnostic = { fg = c.gray, bg = c.bg_dark },
  BufferLineDiagnosticVisible = { fg = c.gray_light, bg = c.bg_dark },
  BufferLineDiagnosticSelected = { fg = c.fg, bg = c.bg },
  
  -- Specific diagnostic types
  BufferLineError = { fg = c.error, bg = c.bg_dark },
  BufferLineErrorVisible = { fg = c.error, bg = c.bg_dark },
  BufferLineErrorSelected = { fg = c.error, bg = c.bg },
  
  BufferLineWarning = { fg = c.warning, bg = c.bg_dark },
  BufferLineWarningVisible = { fg = c.warning, bg = c.bg_dark },
  BufferLineWarningSelected = { fg = c.warning, bg = c.bg },
  
  BufferLineInfo = { fg = c.info, bg = c.bg_dark },
  BufferLineInfoVisible = { fg = c.info, bg = c.bg_dark },
  BufferLineInfoSelected = { fg = c.info, bg = c.bg },
  
  BufferLineHint = { fg = c.hint, bg = c.bg_dark },
  BufferLineHintVisible = { fg = c.hint, bg = c.bg_dark },
  BufferLineHintSelected = { fg = c.hint, bg = c.bg },
  
  -- Pick functionality
  BufferLinePick = { fg = c.orange, bg = c.bg_dark, bold = true },
  BufferLinePickVisible = { fg = c.orange, bg = c.bg_dark, bold = true },
  BufferLinePickSelected = { fg = c.green_light, bg = c.bg, bold = true },
}
