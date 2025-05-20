return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    -- Setup project.nvim
    require("project_nvim").setup({
      manual_mode = true, -- 🔒 Don't automatically change working dir
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "tsconfig.json", "Makefile", "pyproject.toml" },
      exclude_dirs = { "~/Downloads" },

      -- Directory change settings
      silent_chdir = true,
      scope_chdir = "global",

      -- Session management
      store_session = true,
      load_session = true,
      session_lens = false,              -- disable the lens (Telescope UI for sessions)
      datapath = vim.fn.stdpath("data"), -- where sessions are stored
    })

    -- Load telescope projects extension
    require("telescope").load_extension("projects")

    -- 🔧 Optional Keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts) -- Find Project
    keymap("n", "<leader>cd", "<cmd>ProjectRoot<CR>", opts)        -- Change dir manually
  end,
}
