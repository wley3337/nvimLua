local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print("Error loading lualine")
	return
end

-- local function node_version()
-- 	local _node_version = os.execute("./node_version.sh")
-- 	return _node_version
-- end
--  line goes: A | B | C |    X | Y | Z
lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		-- lualine_a = { "mode" },
		-- lualine_b = { "branch", "diff", "diagnostics" },
		-- lualine_c = { { "filename", path = 1 } },
		-- lualine_x = { "fileformat", "filetype" },
		-- lualine_y = { "progress" },
		-- lualine_z = { "location" },
	},
	inactive_sections = {
		-- lualine_a = {},
		-- lualine_b = {},
		-- lualine_c = { "filename" },
		-- lualine_x = { "location" },
		-- lualine_y = {},
		-- lualine_z = {},
	},
	tabline = {
		lualine_a = { { "filename", path = 1 } },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "location" },
		lualine_x = { "buffers" },
		-- lualine_x = { "fileformat", "filetype" },
		lualine_y = { "mode" },
		lualine_z = { "location" },
	},
	extensions = {},
})
