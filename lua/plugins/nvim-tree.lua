return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    vim.g.mapleader = " "

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mappings
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<space>", "<Nop>", { buffer = bufnr })

      vim.keymap.set("n", "m", function()
        local node = api.tree.get_node_under_cursor()
        if not node then return end
        local old_path = node.absolute_path
        vim.ui.input({ prompt = "Move to: ", default = old_path }, function(input)
          if input and input ~= "" and input ~= old_path then
            api.fs.rename(old_path, input)
          end
        end)
      end, opts("Move File"))
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,
      view = {
        width = 30,
      },
      renderer = {
        indent_markers = {
          enable = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = nil,
            folder = {
              arrow_closed = "",  -- nicer arrow icons
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "", 
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              untracked = "U",
              renamed = "R",
              deleted = "D",
              ignored = "I",
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 400,
      },
    })

    -- Optional: highlight tweaks
    vim.cmd [[
      highlight NvimTreeIndentMarker guifg=#555555
      highlight NvimTreeFolderArrowClosed guifg=#999999
      highlight NvimTreeFolderArrowOpen guifg=#999999
      highlight NvimTreeGitUnstaged guifg=#E5C07B
      highlight NvimTreeGitStaged guifg=#98C379
      highlight NvimTreeGitUnmerged guifg=#E06C75
      highlight NvimTreeGitRenamed guifg=#61AFEF
      highlight NvimTreeGitDeleted guifg=#E06C75
      highlight NvimTreeGitUntracked guifg=#56B6C2
      highlight NvimTreeGitIgnored guifg=#7F848E
    ]]
  end,
}

