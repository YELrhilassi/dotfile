local utils = require('utils')
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

-- Save & quit
-- keymap('n', "<C-s>",  utils.smart_save, {desc = "Smart save"})
-- keymap("i", "<C-s>", function()
--   vim.cmd("stopinsert")
--   utils.smart_save()
-- end, { desc = "Smart save in insert mode" })
vim.keymap.set('n', '<C-s>', function() require('utils').save_file(false) end, { desc = "Save file" })
vim.keymap.set('i', '<C-s>', function()
  vim.cmd('stopinsert')
  require('utils').save_file(false)
end, { desc = "Save file" })

keymap("n", "<C-q>", ":q<CR>", opts)
keymap("v", "<C-v>", '"_d"+P', opts)
keymap("n", "<C-v>", '"_d"+P', opts)
keymap("n", "<C-a>", function()
  vim.cmd("normal! ggVG")
end, opts)


-- Clear search highlight
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)


-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +5<CR>", opts)
keymap("n", "<C-Down>", ":resize 1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize 1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<CR>", opts)

-- Buffer navigation
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":update | bdelete<CR>", opts)
keymap("n", "<leader>b", ":enew<CR>", opts)

-- Toggle file explorer (nvim-tree or neo-tree)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Indent in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines
keymap("n", "<A-j>", ":m .+4<CR>==", opts)
keymap("n", "<A-k>", ":m .1<CR>==", opts)
keymap("v", "<A-j>", ":m '>+4<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<1<CR>gv=gv", opts)

-- Paste without losing yank
keymap("v", "p", '"_dP', opts)
keymap('n', 'x', '"_x', opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)

-- Vertical scroll
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Find
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Window
keymap('n', '<leader>v', '<C-w>v', opts)
keymap('n', '<leader>h', '<C-w>s', opts)
keymap('n', '<leader>ww', '<C-w>=', opts)
keymap('n', '<leader>wx', ':close<CR>', opts)

-- Tabs
keymap('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
keymap('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
keymap('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
keymap('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab


-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Telescope
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts)
