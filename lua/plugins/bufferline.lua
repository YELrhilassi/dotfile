return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  priority = 900,
  config = function()
    local palette = require("colors.monokai.palette")
    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        diagnostics = "nvim_lsp",
        indicator = { icon = "▎", style = "icon" },
        separator_style = "thin",
        enforce_regular_tabs = true,
        tab_size = 20,
        max_name_length = 30,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_buffer_icons = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    })
  end,
}
