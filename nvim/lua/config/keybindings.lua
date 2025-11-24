vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set = vim.keymap.set

set('n', '<leader>pv', vim.cmd.Ex)

-- Move selected line / block of text in visual mode
set('n', '<Esc>', ':nohlsearch<CR>')
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics [Q]uickfix list" })

set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Open [D]iagnostic [F]loat" })

set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

-- on ctrl + shift + e open the vim.cmd.Ex
set('n', '<C-S-e>', vim.cmd.Ex, { desc = "Open [E]xplorer" })



-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<C-left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<C-right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<C-up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<C-down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format current buffer' })

















