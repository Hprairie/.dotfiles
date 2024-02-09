-- Bootstrap lazy if it can't be found locally
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Define Packages to be installed by lazy
require("lazy").setup({

    -------------- Navigation ---------------

    -- Setup Telescope
    {'nvim-telescope/telescope.nvim', 
        tag = '0.1.5',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    
    -- Setup Harpoon
    'ThePrimeagen/harpoon',

    -- Setup 0il 
    {"stevearc/oil.nvim",
        config = function()
          require("oil").setup()
        end,
    },

    -- Tmux Navigation
    {"christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
      lazy = false 
    },

    ---------------- Asthetics ----------------
    -- Setup Theme
    {"rebelot/kanagawa.nvim",
        name = 'kanagawa',
    },

    -- Setup Treesitter
    {'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    

    --------------- Rendering -----------------
    -- Image loading in nvim
    

    ---------------- LaTeX -------------------


    --------------- Formatting ----------------
    -- Python Pep-8
    {'Vimjas/vim-python-pep8-indent', 
        lazy = true,
    },

    ------------ Quality of Life --------------
    'tpope/vim-surround', -- Goat plugin
    'tpope/vim-repeat',
    {'folke/neodev.nvim',
        lazy = true
    },

    ------------------ LSP --------------------
    {'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
          --- Uncomment these if you want to manage LSP servers from neovim
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- LSP Support
          {'neovim/nvim-lspconfig'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
        }
    },

})
