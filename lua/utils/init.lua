-- Modified utils/init.lua file to fix file saving issue
-- Save this to ~/.config/nvim/lua/utils/init.lua

local M = {}

-- Check if a file exists
function M.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Safe file write function that handles existing files
function M.write_file(path, contents, force)
  -- Create necessary directories
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "." and not vim.fn.isdirectory(dir) then
    vim.fn.mkdir(dir, "p")
  end

  -- Check if file exists and we're not forcing overwrite
  if not force and M.file_exists(path) then
    -- Get confirmation from user
    local confirm = vim.fn.input(string.format("File %s exists. Overwrite? (y/n): ", path))
    if confirm:lower() ~= "y" then
      print("File not saved")
      return false
    end
  end

  -- Write the file with proper error handling
  local file, err = io.open(path, "wb")
  if not file then
    vim.notify("Couldn't write to " .. path .. ": " .. (err or "unknown error"), vim.log.levels.ERROR)
    return false
  end

  file:write(contents)
  file:close()
  return true
end

-- Safe command execution
function M.safe_cmd(cmd, opts)
  opts = opts or {}
  local ok, result = pcall(vim.cmd, cmd)
  if not ok and opts.fallback then
    return opts.fallback()
  end
  return ok and result
end

-- Format file function that can be used as a replacement for autoformatting
function M.format_file()
  -- Try using LSP formatting first
  local has_lsp_formatting = false

  for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client.supports_method("textDocument/formatting") then
      has_lsp_formatting = true
      vim.lsp.buf.format({ async = false })
      break
    end
  end

  -- Fallback to built-in formatting if no LSP formatter
  if not has_lsp_formatting then
    M.safe_cmd("normal! gg=G", { fallback = function() return false end })
  end
end

-- Custom save function with error handling
function M.save_file(force)
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Skip format and auto commands for specific file types
  local skip_types = { "gitcommit", "gitrebase", "TelescopePrompt" }
  local ft = vim.bo.filetype

  for _, skip_type in ipairs(skip_types) do
    if ft == skip_type then
      -- Just save without formatting for these filetypes
      return M.safe_cmd(force and "write!" or "write", {
        fallback = function()
          vim.notify("Failed to save file: " .. filename, vim.log.levels.ERROR)
          return false
        end
      })
    end
  end

  -- Try to format the file if appropriate
  if vim.g.format_on_save then
    M.format_file()
  end

  -- Save with appropriate force flag
  return M.safe_cmd(force and "write!" or "write", {
    fallback = function()
      vim.notify("Failed to save file: " .. filename, vim.log.levels.ERROR)
      return false
    end
  })
end

-- Create command aliases
function M.create_cmd_alias(cmd, alias)
  vim.api.nvim_create_user_command(alias, function(opts)
    local args = opts.args ~= "" and " " .. opts.args or ""
    vim.cmd(cmd .. args)
  end, { nargs = "*" })
end

return M
