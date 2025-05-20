return {
  "Shatur/neovim-session-manager",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local Path = require('plenary.path')
    local session_config = require('session_manager.config')
    local session_manager = require('session_manager')

    local sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions')

    session_manager.setup({
      sessions_dir = sessions_dir,
      autoload_mode = session_config.AutoloadMode.CurrentDir,
      autosave_last_session = true,
      autosave_ignore_not_normal = false,
      autosave_ignore_dirs = {},
      autosave_ignore_filetypes = {
        'gitcommit',
        'gitrebase',
      },
      autosave_ignore_buftypes = {},
      autosave_only_in_session = false,
      max_path_length = 80,
    })

    local function get_session_path_for_cwd()
      local cwd = vim.fn.getcwd()
      local sanitized = cwd:gsub('/', '%%')
      return sessions_dir:joinpath(sanitized .. ".vim")
    end

    if vim.fn.argc() == 0 then
      local session_file = get_session_path_for_cwd()
      if not session_file:exists() then
        session_manager.load_last_session()
      end
    end

    local config_group = vim.api.nvim_create_augroup('SessionManagerCustom', {})

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = "SessionSavePre",
      group = config_group,
      callback = function()
        local nvimtreeLoaded, nvimtreeView = pcall(require, "nvim-tree.view")
        local dapuiLoaded, dapui = pcall(require, "dapui")
        local neotestLoaded, neotest = pcall(require, "neotest")
        local terminalLoaded, terms = pcall(require, "toggleterm.terminal")
        local bufferDeleteLoaded, bufferDelete = pcall(require, 'bufdelete')
        local lspSagaOutlineLoaded, lspSagaOutline = pcall(require, "lspsaga.outline")

        if lspSagaOutlineLoaded and lspSagaOutline and lspSagaOutline.winid and vim.api.nvim_win_is_valid(lspSagaOutline.winid) then
          vim.cmd("Lspsaga outline")
        end
        if dapuiLoaded and dapui then
          dapui.close()
        end
        if nvimtreeLoaded and nvimtreeView then
          vim.cmd("NvimTreeClose")
        end
        if neotestLoaded and neotest then
          neotest.summary.close()
          neotest.output_panel.close()
        end
        if terminalLoaded and terms then
          local terminals = terms.get_all()
          for _, term in pairs(terminals) do
            term:close()
            if vim.api.nvim_buf_is_loaded(term.bufnr) then
              vim.api.nvim_buf_delete(term.bufnr, { force = true })
            end
          end
        end

        local buffer_filter = function(buf)
          if vim.api.nvim_buf_is_valid(buf) and not vim.api.nvim_buf_get_option(buf, 'buflisted') then
            return true
          end
          return false
        end
        local unlistedBuffers = vim.tbl_filter(buffer_filter, vim.api.nvim_list_bufs())
        for _, buf in pairs(unlistedBuffers) do
          if bufferDeleteLoaded then
            bufferDelete.bufwipeout(buf, true)
          end
        end

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
          end
        end
      end,
    })

    -- Command to clean old session files older than given days (default 30)
    vim.api.nvim_create_user_command("CleanOldSessions", function(opts)
      local days_to_keep = tonumber(opts.args) or 30
      local deleted = 0
      for _, file in ipairs(sessions_dir:iter()) do
        local file_path = Path:new(file)
        local attr = vim.loop.fs_stat(file_path:absolute())
        if attr then
          local age = (os.time() - attr.mtime.sec) / (24 * 3600)
          if age > days_to_keep then
            file_path:rm()
            deleted = deleted + 1
            print("Deleted old session: " .. file_path.filename)
          end
        end
      end
      print(("CleanOldSessions: deleted %d session files older than %d days"):format(deleted, days_to_keep))
    end, {
      nargs = "?",
      desc = "Delete old Neovim session files older than given days (default 30).",
    })
  end
}

