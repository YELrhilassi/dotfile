-- Notify highlights
local c = require('colors.monokai.palette')

return {
  -- Notify base
  NotifyERRORBorder = { fg = c.error },
  NotifyWARNBorder = { fg = c.warning },
  NotifyINFOBorder = { fg = c.info },
  NotifyDEBUGBorder = { fg = c.gray },
  NotifyTRACEBorder = { fg = c.purple },
  
  NotifyERRORIcon = { fg = c.error },
  NotifyWARNIcon = { fg = c.warning },
  NotifyINFOIcon = { fg = c.info },
  NotifyDEBUGIcon = { fg = c.gray },
  NotifyTRACEIcon = { fg = c.purple },
  
  NotifyERRORTitle = { fg = c.error, bold = true },
  NotifyWARNTitle = { fg = c.warning, bold = true },
  NotifyINFOTitle = { fg = c.info, bold = true },
  NotifyDEBUGTitle = { fg = c.gray, bold = true },
  NotifyTRACETitle = { fg = c.purple, bold = true },
  
  NotifyERRORBody = { fg = c.fg, bg = c.bg_dark },
  NotifyWARNBody = { fg = c.fg, bg = c.bg_dark },
  NotifyINFOBody = { fg = c.fg, bg = c.bg_dark },
  NotifyDEBUGBody = { fg = c.fg, bg = c.bg_dark },
  NotifyTRACEBody = { fg = c.fg, bg = c.bg_dark },
}
