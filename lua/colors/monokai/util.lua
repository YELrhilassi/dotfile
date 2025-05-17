local M = {}

function M.blend(color1, color2, alpha)
  local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return {
      r = tonumber(hex:sub(1, 2), 16),
      g = tonumber(hex:sub(3, 4), 16),
      b = tonumber(hex:sub(5, 6), 16)
    }
  end

  local rgb1 = hex_to_rgb(color1)
  local rgb2 = hex_to_rgb(color2)

  local r = math.floor(rgb1.r * (1 - alpha) + rgb2.r * alpha)
  local g = math.floor(rgb1.g * (1 - alpha) + rgb2.g * alpha)
  local b = math.floor(rgb1.b * (1 - alpha) + rgb2.b * alpha)

  return string.format("#%02x%02x%02x", r, g, b)
end

function M.hex_to_hsl(hex)
  hex = hex:gsub("#","")
  local r = tonumber(hex:sub(1,2),16) / 255
  local g = tonumber(hex:sub(3,4),16) / 255
  local b = tonumber(hex:sub(5,6),16) / 255

  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l

  l = (max + min) / 2

  if max == min then
    h = 0
    s = 0
  else
    local d = max - min
    if l > 0.5 then
      s = d / (2 - max - min)
    else
      s = d / (max + min)
    end

    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return {h = h, s = s, l = l}
end

function M.hsl_to_hex(hsl)
  local h, s, l = hsl.h, hsl.s, hsl.l
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l
  else
    local function hue_to_rgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1/6 then return p + (q - p) * 6 * t end
      if t < 1/2 then return q end
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
      return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb(p, q, h + 1/3)
    g = hue_to_rgb(p, q, h)
    b = hue_to_rgb(p, q, h - 1/3)
  end

  local function to_hex(x)
    x = math.floor(x * 255 + 0.5)
    return string.format("%02x", x)
  end

  return "#" .. to_hex(r) .. to_hex(g) .. to_hex(b)
end


function M.darken(color, percent)
  local hsl = M.hex_to_hsl(color)
  hsl.l = math.max(0, hsl.l - (percent / 100))
  return M.hsl_to_hex(hsl)
end

function M.lighten(color, percent)
  local hsl = M.hex_to_hsl(color)
  hsl.l = math.min(100, hsl.l + (percent / 100))
  return M.hsl_to_hex(hsl)
end

function M.subtle_border(group, opts)
  local default = {
    fg = opts.fg or "#454545",
    bg = opts.bg or "NONE",
    style = opts.style or "NONE"
  }
  vim.api.nvim_set_hl(0, group, default)
end

return M