--[[ local jsonls_opts = require("user.lsp.settings.jsonls") ]]
--[[ if server.name == "jsonls" then ]]
--[[     opts = vim.tbl_deep_extend("force", jsonls_opts, opts) ]]
--[[ end ]]
--[[]]
--[[ if server.name == "sumneko_lua" then ]]
--[[     local sumneko_opts = require("user.lsp.settings.sumneko_lua") ]]
--[[     opts = vim.tbl_deep_extend("force", sumneko_opts, opts) ]]
--[[ end ]]
--[[]]
--[[ if server.name == "pyright" then ]]
--[[     local pyright_opts = require("user.lsp.settings.pyright") ]]
--[[     opts = vim.tbl_deep_extend("force", pyright_opts, opts) ]]
--[[ end ]]
--[[ if server.name == "rust_analyzer" then ]]
--[[ end ]]
--[[ require("lspconfig").rust_analyzer.setup({}) ]]
--
-- TJ's auto command for formatting 
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua
-- local augroup_format = vim.api.nvim_create_augroup("my_lsp_format", { clear = true })
--[[ local autocmd_format = function(async, filter) ]]
--[[   vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format } ]]
--[[   vim.api.nvim_create_autocmd("BufWritePre", { ]]
--[[     buffer = 0, ]]
--[[     callback = function() ]]
--[[       vim.lsp.buf.format { async = async, filter = filter } ]]
--[[     end, ]]
--[[   }) ]]
--[[ end ]]

local lsp_key_maps = function()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
end
require'lspconfig'.tsserver.setup ({ on_attach = lsp_key_maps })
require("lspconfig").rust_analyzer.setup({ on_attach = lsp_key_maps })
require("lspconfig").pyright.setup({ on_attach = lsp_key_maps })
require("lspconfig").jsonls.setup({ on_attach = lsp_key_maps })
require'lspconfig'.sumneko_lua.setup {
  on_attach = lsp_key_maps,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
