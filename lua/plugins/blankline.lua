return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    -- Define highlight groups first:
    vim.cmd [[
      highlight IndentBlanklineChar guifg=#454545 gui=nocombine
      highlight IndentBlanklineContextChar guifg=#F9D56E gui=nocombine
    ]]

    -- Then call setup:
    require("ibl").setup {
      indent = {
        char = "│",
        highlight = "IndentBlanklineChar",
      },
      scope = {
        enabled = true,
        show_start = false,
        highlight = "IndentBlanklineContextChar",
      },
      exclude = {
        filetypes = { "help", "startify", "lazy", "NvimTree", "Trouble" },
        buftypes = { "terminal", "nofile" },
      },
    }
  end,
}

