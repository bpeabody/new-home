-- General settings
vim.opt.hidden = true           -- allows switching buffers without saving
vim.opt.syntax = "on"           -- syntax coloring
vim.opt.autoindent = true       -- match indentation of preceding line
vim.opt.expandtab = true        -- use spaces for tab
vim.opt.shiftwidth = 4          -- indent by this much after {, etc
vim.opt.tabstop = 4             -- how many spaces to indent by
vim.opt.smarttab = true
vim.opt.cinoptions:append("(0") -- line up additional arguments to function
vim.opt.textwidth = 79          -- line wrap at 79 chars
vim.opt.visualbell = true       -- don't beep when error, make screen flash
vim.opt.ignorecase = true       -- perform case-insensitive searches
vim.opt.smartcase = true        -- searches are case sensitive if there is one capital letter
vim.opt.hlsearch = true         -- highlights search matches
vim.opt.incsearch = true        -- search as you type
vim.opt.history = 1000          -- remember more history
vim.opt.scrolloff = 3           -- keep some context when scrolling

-- Leader key
vim.g.mapleader = ','

-- Key mappings
vim.api.nvim_set_keymap('n', '-', '<C-W>-', {})
vim.api.nvim_set_keymap('n', '+', '<C-W>+', {})
vim.api.nvim_set_keymap('n', '<leader>v', ':silent :nohlsearch<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>s', ':set nolist!<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':wa<CR>', {})
vim.api.nvim_set_keymap('i', '<C-s>', '<esc>:wa<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>o', ':A<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>a', ':e #<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>z', ':%s/\\<<C-r><C-w>\\>/', {})
vim.api.nvim_set_keymap('n', ';', ':', {})

-- Show whitespace
vim.opt.listchars = { tab = ">-", trail = '·' }
vim.opt.list = true

-- Better command mode completion
vim.opt.wildmode = { 'list', 'longest' }

-- Intuitive backspacing in insert mode
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- Plugin manager (see nvim/lua/plugins.lua)
require('plugins')

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

-- completion, language servers
require("mason").setup {}
require("mason-lspconfig").setup { ensure_installed = { "pyright", }, }
require 'lspconfig'.pyright.setup {}
