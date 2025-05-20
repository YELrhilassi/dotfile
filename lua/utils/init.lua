local M = {}

-- Check if a file exists
function M.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Safe file write (creates dirs, asks before overwrite unless forced)
function M.write_file(path, contents, force)
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "." and not vim.fn.isdirectory(dir) then
    vim.fn.mkdir(dir, "p")
  end

  if not force and M.file_exists(path) then
    local confirm = vim.fn.input(("File %s exists. Overwrite? (y/n): "):format(path))
    if confirm:lower() ~= "y" then
      print("File not saved")
      return false
    end
  end

  local file, err = io.open(path, "wb")
  if not file then
    vim.notify("Couldn't write to " .. path .. ": " .. (err or "unknown error"), vim.log.levels.ERROR)
    return false
  end

  file:write(contents)
  file:close()
  return true
end

-- Custom save function that formats with Conform then writes
function M.save_file(force)
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local ft = vim.bo.filetype

  -- Skip formatting for special filetypes
  local skip = { gitcommit = true, gitrebase = true, TelescopePrompt = true }
  if skip[ft] then
    return vim.cmd((force and "write!" or "write") .. " " .. filename)
  end

  -- Run Conform formatter if enabled
  if vim.g.format_on_save then
    -- you can pass options here; e.g. { bufnr = bufnr, async = false }
    require("conform").format({ bufnr = bufnr, async = false })
  end

  -- Finally write buffer
  return vim.cmd((force and "write!" or "write") .. " " .. filename)
end

-- Alias creator
function M.create_cmd_alias(cmd, alias)
  vim.api.nvim_create_user_command(alias, function(opts)
    local args = opts.args ~= "" and " " .. opts.args or ""
    vim.cmd(cmd .. args)
  end, { nargs = "*" })
end

return M

