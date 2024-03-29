local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Telescope didn't load")
	return
end

--[[ local actions = require "telescope.actions" ]]
--telescope.load_extension "media_files"

telescope.setup({
	defaults = {

		prompt_prefix = "> ",
		selection_caret = " ",
		path_display = { "smart" },
		layout_config = { height = 0.75 },
		--[[ mappings = { ]]
		--[[   i = { ]]
		--[[     ["<C-n>"] = actions.cycle_history_next, ]]
		--[[     ["<C-p>"] = actions.cycle_history_prev, ]]
		--[[]]
		--[[     ["<C-j>"] = actions.move_selection_next, ]]
		--[[     ["<C-k>"] = actions.move_selection_previous, ]]
		--[[]]
		--[[     ["<C-c>"] = actions.close, ]]
		--[[]]
		--[[     ["<Down>"] = actions.move_selection_next, ]]
		--[[     ["<Up>"] = actions.move_selection_previous, ]]
		--[[]]
		--[[     ["<CR>"] = actions.select_default, ]]
		--[[     ["<C-x>"] = actions.select_horizontal, ]]
		--[[     ["<C-v>"] = actions.select_vertical, ]]
		--[[     ["<C-t>"] = actions.select_tab, ]]
		--[[]]
		--[[     ["<C-u>"] = actions.preview_scrolling_up, ]]
		--[[     ["<C-d>"] = actions.preview_scrolling_down, ]]
		--[[]]
		--[[     ["<PageUp>"] = actions.results_scrolling_up, ]]
		--[[     ["<PageDown>"] = actions.results_scrolling_down, ]]
		--[[]]
		--[[     ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse, ]]
		--[[     ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better, ]]
		--[[     ["<C-q>"] = actions.send_to_qflist + actions.open_qflist, ]]
		--[[     ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist, ]]
		--[[     ["<C-l>"] = actions.complete_tag, ]]
		--[[     ["<C-_>"] = actions.which_key, -- keys from pressing <C-/> ]]
		--[[   }, ]]
		--[[]]
		--[[   n = { ]]
		--[[     ["<esc>"] = actions.close, ]]
		--[[     ["<CR>"] = actions.select_default, ]]
		--[[     -- local status_ok, dapui = pcall(require, "dapui") ]]
		--[[     -- if not status_ok then ]]
		--[[     --     print("Error loading dapui") ]]
		--[[     --     return ]]
		--[[     -- end ]]
		--[[     ["<C-x>"] = actions.select_horizontal, ]]
		--[[     ["<C-v>"] = actions.select_vertical, ]]
		--[[     ["<C-t>"] = actions.select_tab, ]]
		--[[]]
		--[[     ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse, ]]
		--[[     ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better, ]]
		--[[     ["<C-q>"] = actions.send_to_qflist + actions.open_qflist, ]]
		--[[     ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist, ]]
		--[[]]
		--[[     ["j"] = actions.move_selection_next, ]]
		--[[     ["k"] = actions.move_selection_previous, ]]
		--[[     ["H"] = actions.move_to_top, ]]
		--[[     ["M"] = actions.move_to_middle, ]]
		--[[     ["L"] = actions.move_to_bottom, ]]
		--[[]]
		--[[     ["<Down>"] = actions.move_selection_next, ]]
		--[[     ["<Up>"] = actions.move_selection_previous, ]]
		--[[     ["gg"] = actions.move_to_top, ]]
		--[[     ["G"] = actions.move_to_bottom, ]]
		--[[]]
		--[[     ["<C-u>"] = actions.preview_scrolling_up, ]]
		--[[     ["<C-d>"] = actions.preview_scrolling_down, ]]
		--[[]]
		--[[     ["<PageUp>"] = actions.results_scrolling_up, ]]
		--[[     ["<PageDown>"] = actions.results_scrolling_down, ]]
		--[[]]
		--[[     ["?"] = actions.which_key, ]]
		--[[   }, ]]
		--[[ }, ]]
		--[[ }, ]]
		pickers = {
			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", --  "ignore_case" or "respect_case" or "smart_case"
				-- the default case_mode is "smart_case"
			},
			--    media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			--     filetypes = { "png", "webp", "jpg", "jpeg" },
			--    find_cmd = "rg", -- find command (defaults to `fd`)
			-- },
			-- defaults
			file_browser = {
				theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				--[[ mappings = { ]]
				--[[ 	["i"] = { ]]
				--[[ 		-- your custom insert mode mappings ]]
				--[[ 	}, ]]
				--[[ 	["n"] = { ]]
				--[[ 		-- your custom normal mode mappings ]]
				--[[ 	}, ]]
				--[[ }, ]]
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local file_exports = {}
file_exports.gui_top_search = function(opts)
	local layout_options = {
		layout_strategies = "horizontal",
		layout_config = { width = 0.5, prompt_position = "top" },
		sorting_strategy = "ascending",
	}
	-- merge the two options letting the incoming options overwrite the layout_options
	for k, v in pairs(opts) do
		layout_options[k] = v
	end
	return layout_options
	-- this is how you would use the theme
	--[[ return require("telescope.themes").get_dropdown(opts) ]]
end

return file_exports
