-- This line is required to use Packer in this file
vim.cmd [[packadd packer.nvim]]

-- Initialize plugins
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
  }

  use {
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
  }

  use {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  --color schemes
  use 'ellisonleao/gruvbox.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'Mofiqul/dracula.nvim'
  use "folke/tokyonight.nvim"
  use "rebelot/kanagawa.nvim"
  use "rose-pine/neovim"

  use "easymotion/vim-easymotion"

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }

  use "folke/trouble.nvim"  -- better diagnostic displays

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use 'mfussenegger/nvim-dap'  -- debugging support
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

  use "sindrets/diffview.nvim"

  use 'mfussenegger/nvim-lint'

end)
