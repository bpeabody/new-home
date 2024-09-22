return {
  -- Lazy itself
  { 'folke/lazy.nvim' },

  -- Essential tools
  { "BurntSushi/ripgrep" },
  { "sharkdp/fd" },

  -- Treesitter with update hook
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  },

  -- Telescope with plenary dependency
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Mason, LSP, and LSPConfig
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -- nvim-cmp and its sources
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },

  -- Vsnip and its cmp integration
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },

  -- LSP signature help
  { "hrsh7th/cmp-nvim-lsp-signature-help" },

  -- Lualine with optional devicons dependency
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Color schemes
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "Mofiqul/dracula.nvim" },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim" },

  -- EasyMotion
  { "easymotion/vim-easymotion" },

  -- Auto pairs on InsertEnter event
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },

  -- Trouble for better diagnostics
  { "folke/trouble.nvim" },

  -- Comment plugin with configuration
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Debugging support with nvim-dap and UI
  { 'mfussenegger/nvim-dap' },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },

  -- Diffview for Git diffs
  { "sindrets/diffview.nvim" },

  -- GitHub Copilot integration
  { "zbirenbaum/copilot.lua" },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- LSP-related plugins
  { "onsails/lspkind.nvim" },        -- icons on popups
  { "VonHeikemen/lsp-zero.nvim" },

  {
      'ray-x/navigator.lua',
      dependencies = {
          { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
          { 'neovim/nvim-lspconfig' },
      },
  },

  -- Indent guides
  { "lukas-reineke/indent-blankline.nvim" },

  {
    'stevearc/conform.nvim',
    opts = {},
  },
}
