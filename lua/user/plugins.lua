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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we do not error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer could not be found or installed")
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
	-- My plugins here
	-- use "user/repo" pattern for import
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("ts-26a/vim-darkspace") -- colorscheme
	use("kyazdani42/nvim-web-devicons") -- dependancy for nvim-tree and recommend for bufferline
	use("kyazdani42/nvim-tree.lua") -- tree file explorer
	use("akinsho/bufferline.nvim") -- recommends nvim-web-devicons as a dependancy
	-- use "moll/vim-bbye"                             -- if you close the last buffer in a split it places a new file there
	-- use "nvim-lualine/lualine.nvim"                 -- status line Lots of options, can put in custom functions too. Add python env and node version
	-- -- use "akinsho/toggleterm.nvim"                  --persistes and toggles multiple terminals. Going to use tmux for this
	use("ahmedkhalf/project.nvim") -- allows switching between projects but maybe also used in treesitter for setting git root
	-- use "lewis6991/impatient.nvim"                  -- optomizes startup by cacheing the packer setup should be required early
	-- use "lukas-reineke/indent-blankline.nvim"       -- marks indenttation in a file
	-- use "goolord/alpha-nvim"                        -- this is a startup page that lists previous openned files on a raw nvim start like spacemacks
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	-- use "folke/which-key.nvim"                      -- bottom of page popup to sugest key bindings like spacemacks

	-- -- Colorschemes
	-- -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("marko-cerovac/material.nvim") -- material colorscheme like using colorscheme material
	use("folke/tokyonight.nvim") -- material colorscheme like using colorscheme material
	-- -- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- lsp handler

	-- -- snippets
	-- use("L3MON4D3/LuaSnip") --snippet engine
	-- use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- -- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("ray-x/lsp_signature.nvim") -- show funciton signiture when you type
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use("nvim-telescope/telescope.nvim") -- dependancy plenary fuzzy finder
	--  use 'nvim-telescope/telescope-media-files.nvim' -- media file preview for telescope only works in Linux

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- Rainbow
	use("p00f/nvim-ts-rainbow")
	-- Comment Context
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring") -- adjust the commenting style based on cursor context ( like different inside JSX vs the JS portion of the file )

	-- -- Git
	use("lewis6991/gitsigns.nvim") -- like gitlens also provides line, hunk diffs
	-- Surround
	-- use("blackcauldron7/surround.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
