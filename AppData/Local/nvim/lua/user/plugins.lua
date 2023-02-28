local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use({ "lewis6991/impatient.nvim", commit = "9f7eed8133d62457f7ad2ca250eb9b837a4adeb7" })
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  -- use("MunifTanjim/nui.nvim")
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-web-devicons")
  use("natecraddock/sessions.nvim")
  use("natecraddock/workspaces.nvim")
  use({ "kyazdani42/nvim-tree.lua", disable = true })
  use("tamago324/lir.nvim")
  use("tamago324/lir-bookmark.nvim")
  use("nanotee/zoxide.vim")
  -- use("elihunter173/dirbuf.nvim")
  use("Sangdol/mintabline.vim")
  use("rebelot/heirline.nvim")
  use("famiu/bufdelete.nvim")
  use("karb94/neoscroll.nvim")
  use("booperlv/nvim-gomove")
  use("goolord/alpha-nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("tpope/vim-repeat")
  use("tpope/vim-abolish")
  use("kylechui/nvim-surround")
  use("rlane/pounce.nvim")
  use("ThePrimeagen/harpoon")
  -- use("ton/vim-bufsurf")
  -- use("mattn/emmet-vim")
  use("tommcdo/vim-exchange")
  use("michaeljsmith/vim-indent-object")
  use("vim-scripts/ReplaceWithRegister")
  use("svban/YankAssassin.vim")
  use("akinsho/toggleterm.nvim")
  use("dstein64/vim-startuptime")
  use("NvChad/nvim-colorizer.lua") -- maintained fork
  use("mrshmllow/document-color.nvim")
  -- use("stevearc/dressing.nvim")
  use("Djancyp/cheat-sheet")
  -- use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
  use("mrjones2014/smart-splits.nvim")
  use({
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
  })
  use({
    "glepnir/hlsearch.nvim",
    -- event = "BufRead",
    config = function()
      require("hlsearch").setup()
    end,
  })

  -- Colorschemes
  use("folke/tokyonight.nvim")

  use({ "catppuccin/nvim", as = "catppuccin" })

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  -- use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("onsails/lspkind.nvim")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine

  -- LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use({ "neovim/nvim-lspconfig", commit = "1393aaca8a59a9ce586ed55770b3a02155a56ac2" })
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  -- use("ray-x/lsp_signature.nvim") -- LSP signature hint as you type
  use("RRethy/vim-illuminate") -- highlight symbols under cursor and cycle through
  use("SmiteshP/nvim-navic")
  use("b0o/SchemaStore.nvim")
  -- use("j-hui/fidget.nvim")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("AckslD/nvim-neoclip.lua")
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "mingw32-make",
  })
  use("nvim-telescope/telescope-ui-select.nvim")
  use("smartpde/telescope-recent-files")
  use("danielvolchek/tailiscope.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  -- use("RRethy/nvim-treesitter-textsubjects")
  use("windwp/nvim-ts-autotag")
  use("m-demare/hlargs.nvim")
  -- use("p00f/nvim-ts-rainbow")

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
