-- 1. Bootstrap Packer (Agar install nahi hai toh download karega)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 2. Safe Require (Check karega packer load ho raha hai ya nahi)
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- 3. Autocommand (File save karte hi auto-sync karne ke liye)
-- Note: plugins-setup.lua par hi map kiya hai ab isse
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- 4. Plugins List aur Startup
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Apne baaki plugins yahan add karein:
  use("bluz71/vim-nightfly-guicolors") -- my colorscheme

  -- Neo-tree: file explorer
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  }

  -- Telescope: fuzzy finder
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- LSP + Mason
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- nvim-cmp: autocompletion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- lualine: statusline
  use "nvim-lualine/lualine.nvim"

  -- gitsigns: git gutter
  use "lewis6991/gitsigns.nvim"

  -- indent-blankline: indent guides
  use "lukas-reineke/indent-blankline.nvim"

  -- which-key: keymap popup
  use "folke/which-key.nvim"

  -- toggleterm: floating terminal
  use "akinsho/toggleterm.nvim"

  -- conform: auto-formatting
  use "stevearc/conform.nvim"

  -- database client
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  use "kristijanhusak/vim-dadbod-completion"

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end)
