-- Rainbow-delimiters highlights
local c = require('colors.monokai.palette')
local  brighten = require('colors.monokai.util').brighten

return {
  -- Rainbow delimiters - nested delimiters
  RainbowDelimiterRed = { fg = brighten(c.pink) },
  RainbowDelimiterYellow = { fg = c.yellow },
  RainbowDelimiterBlue = { fg = brighten(c.blue) },
  RainbowDelimiterOrange = { fg =brighten( c.yellow) },
  RainbowDelimiterGreen = { fg = c.green_light },
  RainbowDelimiterViolet = { fg = c.purple },
  RainbowDelimiterCyan = { fg = c.blue_light },
}
