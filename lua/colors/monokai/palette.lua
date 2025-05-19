-- Monokai Dark Soda palette
local colors = {
  -- Base colors
  bg = "#242424",         -- Background
  bg_dark = "#1c1c1c",    -- Darker background (for status lines, etc.)
  bg_light = "#3D3D3D",   -- Current line
  selection = "#403d3d",  -- Selection
  comment = "#8C8C8C",    -- Comment
  fg = "#F8F8F2",         -- Foreground
  fg_dark = "#d0d0d0",    -- Slightly dimmed foreground
  invisibles = "#65737e", -- Invisibles (whitespace, etc.)
  guides = "#3d3d3d",     -- Indent guides
  
  -- Syntax colors
  string = "#FFEE99",     -- String
  number = "#FF80F4",     -- Number
  red = "#D3201F",        -- Thunderbird
  pink = "#F92672",       -- Radical Red
  purple = "#CD5AC5",     -- Fuchsia Pink
  purple_light = "#FFB2F9", -- Lavender Rose
  yellow = "#d9d145",
  orange = "#FD971F",     -- Tree Poppy
  green = "#60cf30",      -- Atlantis
  green_light = "#A6E22E", -- Pear
  blue = "#66D9EF",       -- Spray
  blue_light = "#90E7F7", -- Malibu
  
  -- Extended palette for UI elements
  gray = "#727272",
  gray_dark = "#525252",
  gray_light = "#b0b0b0",
  error = "#ff5370",
  warning = "#ffcb6b",
  info = "#82aaff",
  hint = "#c3e88d",
  success = "#c3e88d",
  
  -- Git colors
  git_added = "#A6E22E",
  git_modified = "#FD971F",
  git_removed = "#F92672",
  
  -- Transparent
  none = "NONE",
}

return colors
