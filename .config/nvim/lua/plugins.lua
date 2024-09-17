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

end)
