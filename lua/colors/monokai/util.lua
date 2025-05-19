-- Theme generation utility functions
local util = {}
local c = require('colors.monokai.palette')

-- Allow transparent backgrounds
local transparent_background = false

-- Helper function to generate highlight groups
function util.highlight(group, opts)
  local bg = opts.bg or c.none
  local fg = opts.fg or c.none
  local sp = opts.sp or c.none
  
  local config = {
    bg = bg,
    fg = fg,
    sp = sp,
  }
  
  -- Handle special styling attributes
  if opts.bold then config.bold = true end
  if opts.italic then config.italic = true end
  if opts.underline then config.underline = true end
  if opts.undercurl then config.undercurl = true end
  if opts.strikethrough then config.strikethrough = true end
  if opts.reverse then config.reverse = true end
  
  -- Link to another group if specified
  if opts.link then config.link = opts.link end
  
  return config
end

-- Apply background transparency if enabled
function util.apply_transparent_bg(highlights)
  if not transparent_background then
    return highlights
  end
  
  local transparent_groups = {
    "Normal", "NormalNC", "NormalFloat", 
    "SignColumn", "EndOfBuffer", "NormalSB"
  }
  
  for _, group in ipairs(transparent_groups) do
    if highlights[group] then
      highlights[group].bg = c.none
    end
  end
  
  return highlights
end

-- Set transparent background mode
function util.set_transparent(value)
  transparent_background = value
end

-- Return a mix of the theme and plugin highlights
function util.generate_highlights(theme_highlights, plugin_highlights)
  local highlights = vim.tbl_deep_extend("force", theme_highlights, plugin_highlights or {})
  return util.apply_transparent_bg(highlights)
end

-- Clamp helper function
local function clamp(val)
  return math.max(0, math.min(255, val))
end

-- Convert hex to RGB
local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16),
         tonumber(hex:sub(3, 4), 16),
         tonumber(hex:sub(5, 6), 16)
end

-- Convert RGB to hex
local function rgb_to_hex(r, g, b)
  return string.format("#%02X%02X%02X", r, g, b)
end

-- Brighten a hex color by a percentage (0–100)
function util.brighten(hex, percent)
  percent = percent or 20
  local r, g, b = hex_to_rgb(hex)
  r = clamp(r + (255 - r) * (percent / 100))
  g = clamp(g + (255 - g) * (percent / 100))
  b = clamp(b + (255 - b) * (percent / 100))
  return rgb_to_hex(r, g, b)
end

-- Darken a hex color by a percentage (0–100)
function util.darken(hex, percent)
  percent = percent or 20
  local r, g, b = hex_to_rgb(hex)
  r = clamp(r * (1 - percent / 100))
  g = clamp(g * (1 - percent / 100))
  b = clamp(b * (1 - percent / 100))
  return rgb_to_hex(r, g, b)
end


return util
