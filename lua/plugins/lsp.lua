return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
        PATH = "prepend"
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Removed tsserver since we're using typescript-tools.nvim
          "html",        -- HTML
          "cssls",       -- CSS
          "tailwindcss", -- TailwindCSS
          "jsonls",      -- JSON
          "lua_ls",      -- Lua
          "pyright",     -- Python
          "dockerls",    -- Dockerfiles
          "sqlls",       -- SQL
          "emmet_ls",    -- Emmet support
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Common capabilities with LSP and autocompletion support
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      -- Customize how diagnostics are displayed
      vim.diagnostic.config({
        virtual_text = {
          prefix = "◆", -- Use a dot as prefix for virtual text
          source = "if_many",
          format = function(diagnostic)
            -- Trim long messages
            local message = diagnostic.message
            if #message > 50 then
              message = message:sub(1, 47) .. "..."
            end
            return message
          end,
        },
        float = {
          border = "rounded",
          source = true,
          format = function(diagnostic)
            return string.format(
              "%s [%s]",
              diagnostic.message,
              diagnostic.source
            )
          end,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      local monokai_colors = {
        red = "#F92672",
        yellow = "#E6DB74",
        orange = "#FD971F",
        green = "#A6E22E",
        blue = "#66D9EF",
        purple = "#AE81FF",
        bg = "#272822",
        bg_dark = "#1E1F1C",
        bg_light = "#3E3D32",
        fg = "#F8F8F2",
        grey = "#75715E",
      }
      local signs = {
        Error = "",
        Warn = "",
        Hint = "",
        Info = "",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Set Monokai-themed colors for diagnostic highlights
      vim.cmd([[
        highlight DiagnosticError guifg=]] .. monokai_colors.red .. [[ gui=bold
        highlight DiagnosticWarn guifg=]] .. monokai_colors.yellow .. [[ gui=bold
        highlight DiagnosticInfo guifg=]] .. monokai_colors.blue .. [[ gui=bold
        highlight DiagnosticHint guifg=]] .. monokai_colors.green .. [[ gui=bold

        highlight DiagnosticVirtualTextError guifg=]] .. monokai_colors.red .. [[  gui=italic
        highlight DiagnosticVirtualTextWarn guifg=]] .. monokai_colors.yellow .. [[ gui=italic
        highlight DiagnosticVirtualTextInfo guifg=]] .. monokai_colors.blue .. [[  gui=italic
        highlight DiagnosticVirtualTextHint guifg=]] .. monokai_colors.green .. [[  gui=italic

        highlight DiagnosticUnderlineError guisp=]] .. monokai_colors.red .. [[ gui=undercurl
        highlight DiagnosticUnderlineWarn guisp=]] .. monokai_colors.yellow .. [[ gui=undercurl
        highlight DiagnosticUnderlineInfo guisp=]] .. monokai_colors.blue .. [[ gui=undercurl
        highlight DiagnosticUnderlineHint guisp=]] .. monokai_colors.green .. [[ gui=undercurl
      ]])

      -- LSP keymaps
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- disable formatting (we use null-ls/prettier)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- LSP navigation
        bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
        bufmap("n", "K", vim.lsp.buf.hover, "Hover docs")
        bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        -- bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        bufmap("n", "gr", vim.lsp.buf.references, "References")
        bufmap("n", "<leader>D", vim.lsp.buf.type_definition, "")
        bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        bufmap("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
      end

      -- Setup language servers
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- HTML
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "htmldjango" },
      })

      -- CSS
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- TailwindCSS
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                'tw="([^"]*)',
                'tw={"([^"}]*)',
                "tw\\.\\w+`([^`]*)",
                "tw\\(.*?\\)`([^`]*)",
                { "clsx\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "classnames\\(([^)]*)\\)", "'([^']*)'" },
                { "cva\\(([^)]*)\\)",        "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
            validate = true,
          },
        },
      })

      -- JSON
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            -- Using schemastore if available, falling back to defaults if not
            schemas = pcall(require, "schemastore") and require("schemastore").json.schemas() or {},
            validate = { enable = true },
          },
        },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- Docker
      lspconfig.dockerls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- SQL
      lspconfig.sqlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Emmet
      lspconfig.emmet_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      })
    end,
  },
  {
    "b0o/schemastore.nvim",
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
            },
          }),
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:CmpDocSelection,Search:None",
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Set up cmdline completion
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
  -- UI Enhancements
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        notification = {
          override_vim_notify = false,
        },
        text = {
          spinner = "dots", -- Animation style
        },
        window = {
          relative = "editor", -- Where to anchor the window
          blend = 0,           -- &winblend for the window
        },
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = true,
        },
        lightbulb = {
          enable = false,
        },
        ui = {
          title = false,
          border = "rounded",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "💡",
          incoming = " ",
          outgoing = " ",
          hover = " ",
          kind = {},
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- previous item
          next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })
    end,
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          dockerfile = { "hadolint" },
          sh = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  }, {
  "norcalli/nvim-colorizer.lua",
  ft = { "css", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    require("colorizer").setup({
      ["css"] = { css = true },
      ["scss"] = { css = true },
      ["html"] = { css = true },
      ["javascript"] = { css_fn = true },
      ["javascriptreact"] = { css_fn = true },
      ["typescript"] = { css_fn = true },
      ["typescriptreact"] = { css_fn = true },
    })
  end
},
  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "flake8", "mypy" },
        json = { "jsonlint" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        sh = { "shellcheck" },
      }

      -- Create autocommand to lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup({
        auto_open_qflist = true,
        use_trouble_qflist = true,
        auto_start_watch_mode = true,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          },
          tsserver_format_options = {
            insertSpaceAfterCommaDelimiter = true,
            insertSpaceAfterSemicolonInForStatements = true,
            insertSpaceBeforeAndAfterBinaryOperators = true,
            insertSpaceAfterConstructor = false,
            insertSpaceAfterKeywordsInControlFlowStatements = true,
            insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
            insertSpaceBeforeFunctionParenthesis = false,
            insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
            insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
            insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
            insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
            insertSpaceAfterTypeAssertion = false,
            placeOpenBraceOnNewLineForFunctions = false,
            placeOpenBraceOnNewLineForControlBlocks = false,
          },
        },
      })
    end,
  },
}
