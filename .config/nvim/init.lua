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

require("config.lazy")

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

require('telescope').setup{
  pickers = {
    find_files = {
      -- Use git ls-files if inside a git repository
      find_command = { 'git', 'ls-files' }
    },
  },
}

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end

lsp_zero.extend_lspconfig({
  lsp_attach = lsp_attach,
})

-- Go to the next diagnostic (error, warning, etc.)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- Go to the previous diagnostic
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
-- show diagnostics error
vim.api.nvim_set_keymap('n', 'Y', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
-- show list of errors
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
-- show code actions
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })


-- language servers
require("mason").setup {}
require("mason-lspconfig").setup { ensure_installed = { "pyright", }, }

-- must be configured before cmp
require('copilot').setup({
  panel = {
    enabled = false,
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
    enabled = false,
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

-- completion
local lspkind = require('lspkind')
local cmp = require'cmp'

-- Function to check if there's a word before the cursor
-- this is the version that's used w/o copilot; we need more sophistication
--local has_words_before = function()
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

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
    { name = "copilot", group_index = 3},
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'nvim_lsp_signature_help', group_index = 2 },
    { name = 'vsnip', group_index = 2 }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      symbol_map = { Copilot = "" },
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                     -- can also be a function to dynamically calculate max width such as 
                     -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

  mapping = {
    -- Your mappings (e.g., <Tab> for selecting items)
    ['<C-l>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),

    -- Tab to navigate completion menu
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn  == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "", true)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Shift-Tab to navigate backwards
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "", true)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  -- from: https://github.com/zbirenbaum/copilot-cmp on comparators
  -- One custom comparitor for sorting cmp entries is provided: prioritize. The
  -- prioritize comparitor causes copilot entries to appear higher in the cmp
  -- menu. It is recommended keeping priority weight at 2, or placing the exact
  -- comparitor above copilot so that better lsp matches are not stuck below
  -- poor copilot matches.
  --
  -- for some reason I can't require copilot_cmp.comparators; will try again
  -- later
--  sorting = {
--    priority_weight = 2,
--    comparators = {
--      require("copilot_cmp.comparators").prioritize,
--
--      -- Below is the default comparitor list and order for nvim-cmp
--      cmp.config.compare.offset,
--      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
--      cmp.config.compare.exact,
--      cmp.config.compare.score,
--      cmp.config.compare.recently_used,
--      cmp.config.compare.locality,
--      cmp.config.compare.kind,
--      cmp.config.compare.sort_text,
--      cmp.config.compare.length,
--      cmp.config.compare.order,
--    },
--  },
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
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd.colorscheme "catppuccin"  -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme dracula-soft]]
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)


require("ibl").setup {
    -- the following is to set up the blanklines plugin so that
    -- the first column does not obscure the cursor
    indent = { char = '│' },
    scope = { 
        show_start = true, 
        show_end = true 
    },
}

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

require("trouble").setup({
  modes = {
    preview_float = {
      mode = "diagnostics",
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
}
)

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require('lspsaga').setup({
  ui = {
    border = 'rounded',
  },
  symbol_in_winbar = {
    enable = true,
  },
})
require("lspsaga.symbol.winbar").get_bar()

-- Custom key mappings
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { silent = true })
vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { silent = true })
vim.keymap.set('n', 'gP', '<cmd>Lspsaga peek_type_definition<CR>', { silent = true })
vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })
vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
vim.keymap.set('v', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { silent = true })
vim.keymap.set('n', '<A-d>', '<cmd>Lspsaga term_toggle<CR>', { silent = true })


