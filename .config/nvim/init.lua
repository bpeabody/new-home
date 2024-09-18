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

vim.api.nvim_set_keymap('n', '<C-e>', '3<C-e>', { noremap = true, silent = true })

-- Leader key
vim.g.mapleader = ','

-- easymotion
vim.g.EasyMotion_leader_key = '<Leader>'

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

-- language servers
require("mason").setup {}
require("mason-lspconfig").setup { ensure_installed = { "pyright", }, }

-- completion
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
equire("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require 'lspconfig'.pyright.setup {
  capabilities = capabilities
}

require('lualine').setup()

-- colorschemes

-- vim.o.background = "dark" -- or "light" for light mode
--
vim.cmd([[colorscheme gruvbox]])
-- vim.cmd.colorscheme "catppuccin"  -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme dracula-soft]]
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")

require('lint').linters_by_ft = {
  markdown = {'vale',},
  python = {'ruff', 'pylint'},
}

require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

require("ibl").setup()  -- init and config indent-blankline plugin
