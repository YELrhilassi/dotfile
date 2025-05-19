return {
  "echasnovski/mini.bufremove",
  version = false,
  config = function()
    vim.keymap.set("n", "<leader>x", function()
      require("mini.bufremove").delete(0, false)  -- 0 = current buffer, false = don't force
    end, { desc = "Close buffer" })
  end,
}

