-- NvimTree highlights
--local c = require('colors.monokai.palette')
local c = {
 bg = "#242424",         -- Background
  bg_dark = "#1c1c1c",
  fg       = "#D3D3E5", -- main foreground
  blue     = "#8FA1C2", -- folders & symlinks
  blue_light = "#A4B3D0", -- icons
  green    = "#A3BE8C", -- git added, info
  yellow   = "#EBCB8B", -- warnings & merges
  red      = "#BF616A", -- git removed, errors
  purple   = "#B48EAD", -- special files, bookmarks
  pink     = "#D699B6", -- window picker
  gray     = "#5E5F6A", -- empty folders, ignored
  guides   = "#4B4C58", -- indent markers
  git_added    = "#A3BE8C",
  git_modified = "#EBCB8B",
  git_removed  = "#BF616A",
  error   = "#BF616A",
  warning = "#EBCB8B",
  info    = "#88C0D0",
  hint    = "#A3BE8C",
}

return {
  -- NvimTree
  NvimTreeNormal = { fg = c.fg, bg = c.bg_dark },
  NvimTreeEndOfBuffer = { fg = c.bg_dark, bg = c.bg_dark },
  NvimTreeRootFolder = { fg = c.blue, bold = true },
  NvimTreeGitDirty = { fg = c.git_modified },
  NvimTreeGitNew = { fg = c.git_added },
  NvimTreeGitDeleted = { fg = c.git_removed },
  NvimTreeSpecialFile = { fg = c.purple, underline = true },
  NvimTreeIndentMarker = { fg = c.guides },
  NvimTreeImageFile = { fg = c.purple_light },
  NvimTreeSymlink = { fg = c.blue },
  NvimTreeFolderName = { fg = c.blue },
  NvimTreeOpenedFolderName = { fg = c.blue, bold = true },
  NvimTreeEmptyFolderName = { fg = c.gray },
  NvimTreeFolderIcon = { fg = c.blue },
  NvimTreeFileIcon = { fg = c.blue_light },
  NvimTreeWindowPicker = { fg = c.fg, bg = c.pink, bold = true },
  
  -- NvimTree Git
  NvimTreeGitStaged = { fg = c.git_added },
  NvimTreeGitMerge = { fg = c.warning },
  NvimTreeGitRenamed = { fg = c.git_modified },
  NvimTreeGitIgnored = { fg = c.gray },
  
  -- NvimTree Filters
  NvimTreeFileDirty = { fg = c.git_modified },
  NvimTreeFileNew = { fg = c.git_added },
  NvimTreeFileDeleted = { fg = c.git_removed },
  NvimTreeFileStaged = { fg = c.git_added },
  NvimTreeFileMerge = { fg = c.warning },
  NvimTreeFileRenamed = { fg = c.git_modified },
  NvimTreeFileIgnored = { fg = c.gray },
  
  -- NvimTree Bookmarks
  NvimTreeBookmark = { fg = c.purple },
  
  -- NvimTree Diagnostics
  NvimTreeLspDiagnosticsError = { fg = c.error },
  NvimTreeLspDiagnosticsWarning = { fg = c.warning },
  NvimTreeLspDiagnosticsInformation = { fg = c.info },
  NvimTreeLspDiagnosticsHint = { fg = c.hint },
}
