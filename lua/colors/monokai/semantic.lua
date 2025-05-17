local palette = require("colors.monokai.palette")
local util = require("colors.monokai.util")

  return {
  -- LSP semantic tokens
  ["@lsp.type.class"]         = { fg = palette.atlantis },
  ["@lsp.type.decorator"]     = { fg = palette.lavender },
  ["@lsp.type.enum"]          = { fg = palette.spray },
  ["@lsp.type.function"]      = { fg = palette.pear },
  ["@lsp.type.interface"]     = { fg = palette.malibu },
  ["@lsp.type.macro"]         = { fg = palette.radical_red },
  ["@lsp.type.method"]        = { fg = palette.pear },
  ["@lsp.type.namespace"]     = { fg = palette.spray },
  ["@lsp.type.parameter"]     = { fg = palette.fg },
  ["@lsp.type.property"]      = { fg = palette.malibu },
  ["@lsp.type.struct"]        = { fg = palette.atlantis },
  ["@lsp.type.type"]          = { fg = palette.spray },
  ["@lsp.type.typeParameter"] = { fg = palette.malibu },
  ["@lsp.type.variable"]      = { fg = palette.fg },
  
  -- Treesitter groups
  ["@constructor"]            = { fg = palette.spray },
  ["@exception"]              = { fg = palette.radical_red },
  ["@field"]                  = { fg = palette.malibu },
  ["@include"]                = { fg = palette.radical_red },
  ["@parameter"]              = { fg = palette.fg },
  ["@property"]               = { fg = palette.malibu },
  ["@punctuation.bracket"]   = { fg = palette.gold },       -- ()
  ["@punctuation.delimiter"] = { fg = palette.gold_alt },   -- {}
  ["@punctuation.special"]   = { fg = palette.gold },       -- []
  ["@tag"]                    = { fg = palette.radical_red },
  ["@tag.attribute"]          = { fg = palette.pear },
  ["@tag.delimiter"]          = { fg = palette.fuchsia },


   -- JavaScript/TypeScript specific
  ["@keyword.function"]       = { fg = palette.light_blue },
  ["@keyword"]               = { fg = palette.light_blue },  -- const, let, var
  ["@keyword.operator"]      = { fg = palette.pink },       -- =, +, -, etc.
  ["@keyword.return"]        = { fg = palette.light_blue },
  ["@keyword.import"]        = { fg = palette.light_blue },
  ["@keyword.export"]        = { fg = palette.light_blue },
  
 
  
  -- Treesitter context (lighter background)
  TreesitterContext          = { bg = util.darken(palette.current_line, 10) },
  TreesitterContextLineNumber = { fg = palette.tree_poppy },
}