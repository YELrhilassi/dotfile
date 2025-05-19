-- Lualine highlights
local c = require('colors.monokai.palette')

return {
  -- Lualine normal mode
  LualineNormalA = { fg = c.bg, bg = c.blue, bold = true },
  LualineNormalB = { fg = c.fg, bg = c.bg_light },
  LualineNormalC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine insert mode
  LualineInsertA = { fg = c.bg, bg = c.green_light, bold = true },
  LualineInsertB = { fg = c.fg, bg = c.bg_light },
  LualineInsertC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine visual mode
  LualineVisualA = { fg = c.bg, bg = c.purple, bold = true },
  LualineVisualB = { fg = c.fg, bg = c.bg_light },
  LualineVisualC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine replace mode
  LualineReplaceA = { fg = c.bg, bg = c.red, bold = true },
  LualineReplaceB = { fg = c.fg, bg = c.bg_light },
  LualineReplaceC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine command mode
  LualineCommandA = { fg = c.bg, bg = c.orange, bold = true },
  LualineCommandB = { fg = c.fg, bg = c.bg_light },
  LualineCommandC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine inactive mode
  LualineInactiveA = { fg = c.gray, bg = c.bg_dark },
  LualineInactiveB = { fg = c.gray, bg = c.bg_dark },
  LualineInactiveC = { fg = c.gray, bg = c.bg_dark },
  
  -- Lualine terminal mode
  LualineTerminalA = { fg = c.bg, bg = c.green, bold = true },
  LualineTerminalB = { fg = c.fg, bg = c.bg_light },
  LualineTerminalC = { fg = c.fg, bg = c.bg_dark },
  
  -- Lualine diagnostics
  LualineDiagnosticError = { fg = c.error },
  LualineDiagnosticWarn = { fg = c.warning },
  LualineDiagnosticInfo = { fg = c.info },
  LualineDiagnosticHint = { fg = c.hint },
  
  -- Lualine mode separator
  LualineModeSeparatorA = { fg = c.blue, bg = c.bg_light },
  LualineModeSeparatorB = { fg = c.bg_light, bg = c.bg_dark },
  LualineModeSeparatorC = { fg = c.bg_dark, bg = c.bg },
  
  -- Inactive separator
  LualineInactiveSeparator = { fg = c.bg_dark, bg = c.bg_dark },
}
