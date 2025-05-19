return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()

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

  vim.keymap.set("n", "r", function() api.fs.rename() end, opts("Rename"))
  vim.keymap.set("n", "a", function() api.fs.create() end, opts("Create File/Dir"))
  vim.keymap.set("n", "d", function() api.fs.remove() end, opts("Delete"))
  vim.keymap.set("n", "x", function()  api.fs.clear_clipboard()  api.fs.cut()end, opts("Cut"))
  vim.keymap.set("n", "p", function() api.fs.paste() end, opts("Paste"))
  vim.keymap.set("n", "c", function()
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    require("nvim-tree.api").fs.copy.node(node)
  end, opts("Copy"))
  vim.keymap.set("n", "<Esc>", function()
    api.marks.clear()      -- clear marked nodes (optional)
    api.fs.clear_clipboard() -- clear the internal cut/copy clipboard
  end, opts("Cancel Copy/Cut"))


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

  vim.keymap.set("n", "<Tab>", function()
    local node = api.tree.get_node_under_cursor()
    if node and node.type == "directory" then
      api.tree.change_root_to_node(node)
    else
      vim.notify("Not a directory", vim.log.levels.WARN)
    end
  end, opts("CD into dir"))

  vim.keymap.set("n", "<S-Tab>", function()
    api.tree.change_root_to_parent()
  end, opts("CD out to parent"))
end


require("nvim-tree").setup({
  on_attach = my_on_attach,
  view = {
    width = 30,
  },
  renderer = {
    highlight_git = true,
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
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
  })

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
    highlight NvimTreeGitIgnored guifg=#5C6370
    highlight NvimTreeGitDirty guifg=#E5C07B
    highlight NvimTreeGitMerge guifg=#56B6C2
    highlight NvimTreeGitNew guifg=#98C379
  ]] 

  end,
}

