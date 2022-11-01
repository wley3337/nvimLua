-- local colorscheme = "material"
-- local colorscheme = "tokyonight" -- favorite so far
-- local colorscheme = "darkspace"
-- local colorscheme = "onedark" -- link: https://github.com/navarasu/onedark.nvim#installation
local colorscheme = "tokyodark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found")
	return
else
	-- colorscheme specific setups
	if colorscheme == "onedark" then
		require("onedark").setup({
			style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		})
		require("onedark").load()
	end
	if colorscheme == "tokyodark" then
		vim.g.tokyodark_transparent_background = false
		--[[ vim.g.tokyodark_enable_italic_comment = true ]]
		--[[ vim.g.tokyodark_enable_italic = true ]]
		--[[ vim.g.tokyodark_color_gamma = "1.0" ]]
		vim.cmd("colorscheme tokyodark")
	end

	-- color scheme variants
	-- vim.g.material_style= "deep ocean"
	-- vim.g.material_style= "oceanic"
	-- vim.g.material_style= "palenight"
	-- vim.g.material_style= "lighter"
	-- vim.g.material_style= "darker"
end
