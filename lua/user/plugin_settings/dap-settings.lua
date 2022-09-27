--[[ local status_ok, dapui = pcall(require, "dapui") ]]
--[[ if not status_ok then ]]
--[[     print("Error loading dapui") ]]
--[[     return ]]
--[[ end ]]


require('dap-go').setup()

require('dapui').setup()
