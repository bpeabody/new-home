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

-- " For vsnip users.
-- Plug 'hrsh7th/cmp-vsnip'
-- Plug 'hrsh7th/vim-vsnip'
-- 
-- " For luasnip users.
-- " Plug 'L3MON4D3/LuaSnip'
-- " Plug 'saadparwaiz1/cmp_luasnip'
-- 
-- " For ultisnips users.
-- " Plug 'SirVer/ultisnips'
-- " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
-- 
-- " For snippy users.
-- " Plug 'dcampos/nvim-snippy'
-- " Plug 'dcampos/cmp-snippy'

end)
