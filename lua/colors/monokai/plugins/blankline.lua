


local c = {
  indent_line = "#3A3A3A",             -- subtle but visible indent line color
  indent_context = "#505050",          -- slightly stronger for current context indent
}

return {
  IndentBlanklineChar = { fg = c.indent_line },
  IndentBlanklineContextChar = { fg = c.indent_context, bold = true },
}
