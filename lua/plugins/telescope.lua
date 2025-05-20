
local function telescope_highlights()
  local colors = {
    fg = "#F8F8F2",
    bg = "#242424",
    alt_bg = "#2D2D2D",
    selection = "#3A3A3A",
    comment = "#8C8C8C",
    accent = "#90E7F7",   -- Soft blue
    match = "#F92672",    -- Pink for match
    border = "#505050",
  }

  local hl = vim.api.nvim_set_hl

  hl(0, "TelescopeNormal",         { fg = colors.fg, bg = colors.bg })
  hl(0, "TelescopeBorder",         { fg = colors.border, bg = colors.bg })
  hl(0, "TelescopePromptNormal",   { fg = colors.fg, bg = colors.alt_bg })
  hl(0, "TelescopePromptBorder",   { fg = colors.border, bg = colors.alt_bg })
  hl(0, "TelescopePromptTitle",    { fg = colors.accent, bold = true, bg = colors.alt_bg })
  hl(0, "TelescopeResultsNormal",  { fg = colors.fg, bg = colors.bg })
  hl(0, "TelescopeResultsTitle",   { fg = colors.comment, bg = colors.bg })
  hl(0, "TelescopeSelection",      { fg = colors.fg, bg = colors.selection, bold = true })
  hl(0, "TelescopeMatching",       { fg = colors.match, bold = true })
end
return {
  "nvim-telescope/telescope.nvim",
  version = false, -- always latest
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        winblend = 10,
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<Esc><Esc>"]= actions.close, 
          },
        },
       file_ignore_patterns = {
          "%.git/", "node_modules/", "dist/", "build/", "%.lock", "__pycache__/",
          "%.o", "%.a", "%.out", "%.class", "%.exe", "%.dll", "%.jpg", "%.png", "%.svg", "%.ico"
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope_highlights()
  -- Load extensions
    pcall(require("telescope").load_extension, "fzf")
  end,
}

