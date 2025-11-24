local set = vim.opt

-- configure tabs
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

-- Line numbers
set.number = true
set.relativenumber = true

-- Clipboard
set.clipboard = "unnamedplus"

set.termguicolors = true
set.background = "dark"

-- Enable nerd fonts
vim.g.have_nerd_font = true
set.guifont = "Cascadia Code NF:h12"

-- Enable mouse support
set.mouse = 'a'

set.showmode = false

-- Enable break indent
set.breakindent = true

-- Save undo history
set.undofile = true

-- Case insensitive searching unless /C or capital in search
set.ignorecase = true
set.smartcase = true

-- Keep signcolumn on by default
set.signcolumn = "yes"

-- Decrease update time
set.updatetime = 50

-- Split windows - how new splits should be opened
set.splitright = true
set.splitbelow = true

-- Cursor line - Show on which line the cursor is on
set.cursorline = false

-- Scrolloff - Minimum number of screen lines to keep above and below the cursor
set.scrolloff = 10

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
