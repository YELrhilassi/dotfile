return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitGutterChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitGutterDeleteChange', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitGutterChangeDelete', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,
      linehl = false,
      word_diff = false,
    })
vim.cmd [[
  highlight! link GitSignsAdd DiffAdd
  highlight! link GitSignsChange DiffChange
  highlight! link GitSignsDelete DiffDelete
]]
  end,
}
