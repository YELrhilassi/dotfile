return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
     npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- Only disable in string nodes
    javascript = { "string", "template_string" },
    javascriptreact = { "jsx_element", "jsx_fragment", "string", "template_string" },
    typescript = { "string", "template_string" },
    typescriptreact = { "jsx_element", "jsx_fragment", "string", "template_string" },
  },
  disable_filetype = { "TelescopePrompt", "vim" },
})
      -- Add custom rule for self-closing JSX tags
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      -- When you type "/>" automatically complete with a closing tag if appropriate
      npairs.add_rules({
        Rule("/>", "/>", "typescriptreact")
          :use_regex(true)
          :replace_endpair(function(opts)
            local line = opts.line
            local col = opts.col
            local before = line:sub(1, col - 2)
            -- check if before ends with an opening tag, if yes, auto insert closing tag
            local tag = before:match("<([%w:_-]+)[^>]*$")
            if tag then
              return "/>" .. "</" .. tag .. ">"
            end
            return "/>"
          end)
          :set_end_pair_length(2)
      })
    end,
  },
}

