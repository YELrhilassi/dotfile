return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { icon = "" },
          search_down = { icon = " " },
          search_up = { icon = " " },
          filter = { icon = "" },
          lua = { icon = "" },
          help = { icon = "" },
        },
      },
      messages = {
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
      presets = {
        bottom_search = false,        -- classic bottom search bar?
        command_palette = true,       -- command line + search together
        long_message_to_split = true, -- long messages in split view
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter =  {
            event =  "notify",
            kind = "info",
            any = {
              { find = "NvimTree" },
              { find = "added" },
              { find = "created" },
              { find = "deleted" },
              { find = "removed" },
              { find = "clipboard" },
              { find = "renamed" },
              { find = "opened" },
              { find = "closed" },
              { find = "successfully" },
              { find = "lines" },
              { find = "Clipboard"}
            }
          },
          opts = { skip = true }
        }
      },
      lsp = {
      progress = { enabled = false },
      hover = { enabled = true },
      signature = { enabled = false },
    },
      
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    views = {
      mini = {
        win_options = {
          winblend = 20,
        },
      },
    },
    })

    require("notify").setup({
      background_colour = "#000000",
      render = "compact",
      stages = "fade_in_slide_out",
      timeout = 3000,
    })
  end,
}

