local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	print("Dap didn't load")
	return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	print("Dap Ui didn't load")
	return
end

dapui.setup(
	--defaults
	--[[   { ]]
	--[[ 	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" }, ]]
	--[[ 	mappings = { ]]
	--[[ 		-- Use a table to apply multiple mappings ]]
	--[[ 		expand = { "<CR>", "<2-LeftMouse>" }, ]]
	--[[ 		open = "o", ]]
	--[[ 		remove = "d", ]]
	--[[ 		edit = "e", ]]
	--[[ 		repl = "r", ]]
	--[[ 		toggle = "t", ]]
	--[[ 	}, ]]
	--[[ 	-- Expand lines larger than the window ]]
	--[[ 	-- Requires >= 0.7 ]]
	--[[ 	expand_lines = vim.fn.has("nvim-0.7") == 1, ]]
	--[[ 	-- Layouts define sections of the screen to place windows. ]]
	--[[ 	-- The position can be "left", "right", "top" or "bottom". ]]
	--[[ 	-- The size specifies the height/width depending on position. It can be an Int ]]
	--[[ 	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while ]]
	--[[ 	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns) ]]
	--[[ 	-- Elements are the elements shown in the layout (in order). ]]
	--[[ 	-- Layouts are opened in order so that earlier layouts take priority in window sizing. ]]
	--[[ 	layouts = { ]]
	--[[ 		{ ]]
	--[[ 			elements = { ]]
	--[[ 				-- Elements can be strings or table with id and size keys. ]]
	--[[ 				{ id = "scopes", size = 0.25 }, ]]
	--[[ 				"breakpoints", ]]
	--[[ 				"stacks", ]]
	--[[ 				"watches", ]]
	--[[ 			}, ]]
	--[[ 			size = 40, -- 40 columns ]]
	--[[ 			position = "left", ]]
	--[[ 		}, ]]
	--[[ 		{ ]]
	--[[ 			elements = { ]]
	--[[ 				"repl", ]]
	--[[ 				"console", ]]
	--[[ 			}, ]]
	--[[ 			size = 0.25, -- 25% of total lines ]]
	--[[ 			position = "bottom", ]]
	--[[ 		}, ]]
	--[[ 	}, ]]
	--[[ 	controls = { ]]
	--[[ 		-- Requires Neovim nightly (or 0.8 when released) ]]
	--[[ 		enabled = true, ]]
	--[[ 		-- Display controls in this element ]]
	--[[ 		element = "repl", ]]
	--[[ 		icons = { ]]
	--[[ 			pause = "", ]]
	--[[ 			play = "", ]]
	--[[ 			step_into = "", ]]
	--[[ 			step_over = "", ]]
	--[[ 			step_out = "", ]]
	--[[ 			step_back = "", ]]
	--[[ 			run_last = "↻", ]]
	--[[ 			terminate = "□", ]]
	--[[ 		}, ]]
	--[[ 	}, ]]
	--[[ 	floating = { ]]
	--[[ 		max_height = nil, -- These can be integers or a float between 0 and 1. ]]
	--[[ 		max_width = nil, -- Floats will be treated as percentage of your screen. ]]
	--[[ 		border = "single", -- Border style. Can be "single", "double" or "rounded" ]]
	--[[ 		mappings = { ]]
	--[[ 			close = { "q", "<Esc>" }, ]]
	--[[ 		}, ]]
	--[[ 	}, ]]
	--[[ 	windows = { indent = 1 }, ]]
	--[[ 	render = { ]]
	--[[ 		max_type_length = nil, -- Can be integer or nil. ]]
	--[[ 		max_value_lines = 100, -- Can be integer or nil. ]]
	--[[ 	}, ]]
	--[[ } ]]
)

dap.adapters.lldb = {
	type = "executable",
	--[[ command = "/Users/hal/.vscode/extensions/lanza.lldb-vscode-0.2.3/bin", -- adjust as needed, must be absolute path ]]
	command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}
-- Brew suggestions for needing to update path, use if needed
-- To use the bundled libc++ please add the following LDFLAGS:
--[[   LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++" ]]
--[[]]
--[[ llvm is keg-only, which means it was not symlinked into /opt/homebrew, ]]
--[[ because macOS already provides this software and installing another version in ]]
--[[ parallel can cause all kinds of trouble. ]]
--[[]]
--[[ If you need to have llvm first in your PATH, run: ]]
--[[   echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc ]]
--[[]]
--[[ For compilers to find llvm you may need to set: ]]
--[[   export LDFLAGS="-L/opt/homebrew/opt/llvm/lib" ]]
--[[   export CPPFLAGS="-I/opt/homebrew/opt/llvm/include" ]]
-- adapter installation: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python
-- python
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "/usr/bin/python"
		end,
	},
}
-- this is for go
require("dap-go").setup()
-- rust
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Name of app: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		--[[ program = "${workspaceFolder}/target/debug/mars_calc", ]]
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}
