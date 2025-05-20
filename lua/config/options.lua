-- Basic UI
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.mouse          = "a"
vim.opt.termguicolors  = true
vim.opt.signcolumn     = "yes"
vim.opt.wrap           = false
vim.opt.linebreak      = true
vim.opt.fillchars      = "eob: "
vim.opt.cursorline     = true

-- Tabs & indentation
vim.opt.expandtab      = true
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2
vim.opt.smartindent    = true

-- Searching
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.hlsearch       = true
vim.opt.incsearch      = true

-- Files
vim.opt.backup         = false
vim.opt.writebackup    = false
vim.opt.swapfile       = false
vim.opt.undofile       = true

-- Split behavior
vim.opt.splitbelow     = true
vim.opt.splitright     = true

-- Clipboard
vim.opt.clipboard      = "unnamedplus"

-- Scroll
vim.opt.scrolloff      = 8

-- Messages
vim.opt.shortmess:append("F") -- Don't show file info when editing
vim.opt.shortmess:append("c") -- Don't show completion messages
vim.opt.shortmess:append("I") -- Disable intro message
