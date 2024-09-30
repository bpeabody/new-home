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
      'nvimdev/lspsaga.nvim',
      dependencies = {
          'nvim-treesitter/nvim-treesitter', -- optional
          'nvim-tree/nvim-web-devicons',     -- optional
      }
  },

  -- Indent guides
  { "lukas-reineke/indent-blankline.nvim" },

  {
    'stevearc/conform.nvim',
    opts = {},
  },

  { "stevearc/aerial.nvim" },

  {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
          file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
  },


  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    config = true
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          -- Actions
          vim.keymap.set('n', '<leader>ghs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' })
          vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' })
          vim.keymap.set('v', '<leader>ghs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { buffer = bufnr, desc = 'Stage Selected Hunks' })
          vim.keymap.set('v', '<leader>ghr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { buffer = bufnr, desc = 'Reset Selected Hunks' })
          vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
          vim.keymap.set('n', '<leader>ghb', function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = 'Blame Line' })
          vim.keymap.set('n', '<leader>ghd', gs.diffthis, { buffer = bufnr, desc = 'Diff This' })
        end,
      })
    end,
  },

  { "ggandor/leap.nvim" },
}

