-- Git plugins configuration for Neovim with Lazy
-- Place this in your lazy plugin configuration file

return {
  -- Gitsigns: Git decorations and hunk management
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      })
      -- Color overrides on ColorScheme event
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Gitsigns colors (Monokai inspired)
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#A6E22E", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#E6DB74", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F92672", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#F92672", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#FD971F", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#66D9EF", bg = "NONE" })

        -- Gitsigns staged colors
        vim.api.nvim_set_hl(0, "GitSignsAddStaged", { fg = "#A6E22E", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChangeStaged", { fg = "#E6DB74", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteStaged", { fg = "#F92672", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsTopdeleteStaged", { fg = "#F92672", bg = "NONE" })
        vim.api.nvim_set_hl(0, "GitSignsChangedeleteStaged", { fg = "#FD971F", bg = "NONE" })

        -- DiffView colors
        vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#A6E22E", bg = "#2D4A22" })
        vim.api.nvim_set_hl(0, "DiffChange", { fg = "#E6DB74", bg = "#4A4A2D" })
        vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#F92672", bg = "#4A2D2D" })
        vim.api.nvim_set_hl(0, "DiffText", { fg = "#FD971F", bg = "#4A3D2D", bold = true })

        -- Git Conflict colors
        vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#2D4A22" })
        vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#2D2D4A" })
        vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#4A2D4A" })
        vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { fg = "#A6E22E", bold = true })
        vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { fg = "#66D9EF", bold = true })
        vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { fg = "#AE81FF", bold = true })

        -- Git Blame colors
        vim.api.nvim_set_hl(0, "gitblame", { fg = "#75715E", italic = true })
      end,
    })

    -- Quick access commands
    vim.api.nvim_create_user_command("GitHistory", "DiffviewFileHistory", {})
    vim.api.nvim_create_user_command("GitHistoryFile", "DiffviewFileHistory %", {})
    vim.api.nvim_create_user_command("GitDiff", "DiffviewOpen", {})
    vim.api.nvim_create_user_command("GitStatus", "Neogit", {})
    vim.api.nvim_create_user_command("GitConflicts", "GitConflictListQf", {})
    end,
  },

  -- DiffView: Advanced diff and merge conflict resolution
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {}
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {}
          },
        },
        commit_log_panel = {
          win_config = {
            win_opts = {},
          }
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open diff for next file" } },
            { "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Open diff for prev file" } },
            { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file in new tab" } },
            { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in split" } },
            { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open file in new tab" } },
            { "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle diff layout" } },
            { "n", "[x", require("diffview.actions").prev_conflict, { desc = "Previous conflict" } },
            { "n", "]x", require("diffview.actions").next_conflict, { desc = "Next conflict" } },
          },
          diff1 = {
            { "n", "g?", require("diffview.actions").help({ "view", "diff1" }), { desc = "Open help panel" } },
          },
          diff2 = {
            { "n", "g?", require("diffview.actions").help({ "view", "diff2" }), { desc = "Open help panel" } },
          },
          diff3 = {
            { "n", "g?", require("diffview.actions").help({ "view", "diff3" }), { desc = "Open help panel" } },
          },
          diff4 = {
            { "n", "g?", require("diffview.actions").help({ "view", "diff4" }), { desc = "Open help panel" } },
          },
          file_panel = {
            { "n", "j", require("diffview.actions").next_entry, { desc = "Next entry" } },
            { "n", "<down>", require("diffview.actions").next_entry, { desc = "Next entry" } },
            { "n", "k", require("diffview.actions").prev_entry, { desc = "Previous entry" } },
            { "n", "<up>", require("diffview.actions").prev_entry, { desc = "Previous entry" } },
            { "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "o", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "l", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "<2-LeftMouse>", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "-", require("diffview.actions").toggle_stage_entry, { desc = "Stage/unstage file" } },
            { "n", "S", require("diffview.actions").stage_all, { desc = "Stage all" } },
            { "n", "U", require("diffview.actions").unstage_all, { desc = "Unstage all" } },
            { "n", "X", require("diffview.actions").restore_entry, { desc = "Restore entry" } },
            { "n", "L", require("diffview.actions").open_commit_log, { desc = "Open commit log" } },
            { "n", "zo", require("diffview.actions").open_fold, { desc = "Open fold" } },
            { "n", "h", require("diffview.actions").close_fold, { desc = "Close fold" } },
            { "n", "zc", require("diffview.actions").close_fold, { desc = "Close fold" } },
            { "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
            { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Open all folds" } },
            { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Close all folds" } },
            { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll view up" } },
            { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll view down" } },
            { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Next entry" } },
            { "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Previous entry" } },
            { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file" } },
            { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in split" } },
            { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open file in tab" } },
            { "n", "i", require("diffview.actions").listing_style, { desc = "Toggle listing style" } },
            { "n", "f", require("diffview.actions").toggle_flatten_dirs, { desc = "Toggle flatten dirs" } },
            { "n", "R", require("diffview.actions").refresh_files, { desc = "Refresh files" } },
            { "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle layout" } },
            { "n", "[x", require("diffview.actions").prev_conflict, { desc = "Previous conflict" } },
            { "n", "]x", require("diffview.actions").next_conflict, { desc = "Next conflict" } },
            { "n", "g?", require("diffview.actions").help("file_panel"), { desc = "Open help panel" } },
            { "n", "<leader>cO", "<Cmd>DiffviewOpen<CR>", { desc = "Open DiffView" } },
            { "n", "<leader>cC", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" } },
          },
          file_history_panel = {
            { "n", "g!", require("diffview.actions").options, { desc = "Open options panel" } },
            { "n", "<C-A-d>", require("diffview.actions").open_in_diffview, { desc = "Open in diffview" } },
            { "n", "y", require("diffview.actions").copy_hash, { desc = "Copy hash" } },
            { "n", "L", require("diffview.actions").open_commit_log, { desc = "Show commit details" } },
            { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Open all folds" } },
            { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Close all folds" } },
            { "n", "j", require("diffview.actions").next_entry, { desc = "Next entry" } },
            { "n", "<down>", require("diffview.actions").next_entry, { desc = "Next entry" } },
            { "n", "k", require("diffview.actions").prev_entry, { desc = "Previous entry" } },
            { "n", "<up>", require("diffview.actions").prev_entry, { desc = "Previous entry" } },
            { "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "o", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "<2-LeftMouse>", require("diffview.actions").select_entry, { desc = "Open diff" } },
            { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll view up" } },
            { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll view down" } },
            { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Next entry" } },
            { "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Previous entry" } },
            { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file" } },
            { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in split" } },
            { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open file in tab" } },
            { "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle layout" } },
            { "n", "g?", require("diffview.actions").help("file_history_panel"), { desc = "Open help panel" } },
          },
          option_panel = {
            { "n", "<tab>", require("diffview.actions").select_entry, { desc = "Change option" } },
            { "n", "q", require("diffview.actions").close, { desc = "Close panel" } },
            { "n", "g?", require("diffview.actions").help("option_panel"), { desc = "Open help panel" } },
          },
          help_panel = {
            { "n", "q", require("diffview.actions").close, { desc = "Close help panel" } },
          },
        },
      })

      -- Key mappings for DiffView
      vim.keymap.set("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "Open DiffView" })
      vim.keymap.set("n", "<leader>gD", "<Cmd>DiffviewClose<CR>", { desc = "Close DiffView" })
      vim.keymap.set("n", "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", { desc = "File History" })
      vim.keymap.set("n", "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", { desc = "Current File History" })
    end,
  },

  -- Neogit: Magit-like Git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        auto_refresh = true,
        sort_branches = "-committerdate",
        kind = "tab",
        signs = {
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = {
          diffview = true,
          telescope = true,
        },
        sections = {
          untracked = {
            folded = false,
          },
          unstaged = {
            folded = false,
          },
          staged = {
            folded = false,
          },
          stashes = {
            folded = true,
          },
          unpulled = {
            folded = true,
          },
          unmerged = {
            folded = false,
          },
          recent = {
            folded = true,
          },
        },
        mappings = {
          status = {
            ["q"] = "Close",
            ["I"] = "InitRepo",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["<tab>"] = "Toggle",
            ["x"] = "Discard",
            ["s"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["u"] = "Unstage",
            ["U"] = "UnstageStaged",
            ["d"] = "DiffAtFile",
            ["$"] = "CommandHistory",
            ["<c-r>"] = "RefreshBuffer",
            ["<enter>"] = "GoToFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["{"] = "GoToPreviousHunkHeader",
            ["}"] = "GoToNextHunkHeader",
          }
        }
      })

      vim.keymap.set("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Open Neogit" })
      vim.keymap.set("n", "<leader>gc", "<Cmd>Neogit commit<CR>", { desc = "Git Commit" })
      vim.keymap.set("n", "<leader>gp", "<Cmd>Neogit push<CR>", { desc = "Git Push" })
      vim.keymap.set("n", "<leader>gl", "<Cmd>Neogit pull<CR>", { desc = "Git Pull" })
    end,
  },

  -- Git Blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    config = function()
      require("gitblame").setup({
        enabled = false, -- Start disabled, toggle with command
        message_template = " <summary> • <date> • <author>",
        date_format = "%m-%d-%Y",
        virtual_text_column = 1,
        highlight_group = "Question",
        set_extmark_options = {},
        display_virtual_text = true,
        ignored_filetypes = {},
        delay = 1000,
        message_when_not_committed = "  Not Committed Yet",
        use_blame_commit_file_urls = false,
      })

      vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>", { desc = "Toggle Git Blame" })
      vim.keymap.set("n", "<leader>gB", "<Cmd>GitBlameOpenCommitURL<CR>", { desc = "Open Commit URL" })
    end,
  },

  -- Git Conflict Resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        }
      })

      -- Additional keymaps for conflict resolution
      vim.keymap.set("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Choose Ours" })
      vim.keymap.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Choose Theirs" })
      vim.keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Choose Both" })
      vim.keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", { desc = "Choose None" })
      vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Next Conflict" })
      vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Prev Conflict" })
    end,
  },
}

