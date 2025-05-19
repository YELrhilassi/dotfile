local M = {}

M.smart_save = function()
  if vim.bo.modified then
    local cwd = vim.fn.getcwd()
    if vim.api.nvim_buf_get_name(0) == "" then
      -- show current working directory as base
      print("Current directory: " .. cwd)
      local filename = vim.fn.input("Save as (relative to cwd): ", "", "file")
      if filename ~= "" then
        local full_path = cwd .. "/" .. filename
        vim.cmd("saveas " .. full_path)
        print("Saved to: " .. full_path)
      end
    else
      vim.cmd("write")
      print("Saved to: " .. vim.api.nvim_buf_get_name(0))
    end
  end
end

return M
