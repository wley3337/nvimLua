-- Telescope exports
local cust_telescope = require("user.telescope")
-- cmp completion
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local go_to_ref = function()
	--[[ vim.lsp.buf.references({ includeDeclaration = false }) ]]
	local opts = {
		include_declaration = false,
	}
	require("telescope.builtin").lsp_references(cust_telescope.gui_top_search(opts))
end

local lsp_key_maps = function()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "gr", go_to_ref, { buffer = 0 })
	-- need to sort out how to run the diagnostics to a telescope list
	--[[ vim.keymap.set("n", "<C-k>", require("telescope.builtin").lsp) ]]
end

local augroup = vim.api.nvim_create_augroup("LSPFormatting", {})
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
	lsp_key_maps()
end

require("lspconfig").tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").pyright.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").jsonls.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
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
})
