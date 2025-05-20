return {
  "stevearc/resession.nvim",
  opts = {
    autosave = {
      enabled = false, -- we'll autosave manually on exit instead
    },
    load_last = true,
  },
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)

    -- Autosave the "last" session on exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        resession.save("last", { notify = false })
      end,
    })

 -- Auto-save session when leaving a project
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local cwd = vim.fn.getcwd()
        resession.save(cwd, { notify = false })
      end,
    })

    -- Auto-load session on entering a project
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local cwd = vim.fn.getcwd()
        if resession.get(cwd) then
          resession.load(cwd, { silence_errors = true })
        end
      end,
    })

    -- Load Telescope extension if available
    pcall(function()
      require("telescope").load_extension("resession")
    end)
  end,
  keys = {
    { "<leader>ss", function() require("resession").save() end, desc = "Save session" },
    { "<leader>sl", function() require("resession").load() end, desc = "Load session" },
    { "<leader>sd", function() require("resession").delete() end, desc = "Delete session" },
    { "<leader>sr", "<cmd>Telescope resession list<CR>", desc = "Restore session (Telescope)" },
  },
}

