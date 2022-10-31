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
	local keymap_opts = { buffer = 0 }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
	vim.keymap.set("n", "gr", go_to_ref, keymap_opts)
	-- Code navigation and shortcuts
	vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
	vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
	vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
	--[[ vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts) ]]
	vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
	vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
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

local rust_on_attach = function(client, bufnr)
	local keymap_opts = { buffer = 0 }
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
	-- Additional rust specific setup
	-- Set updatetime for CursorHold
	-- 300ms of no cursor movement to trigger CursorHold
	vim.opt.updatetime = 100

	-- Show diagnostic popup on cursor hover
	local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, { focusable = false })
		end,
		group = diag_float_grp,
	})

	-- Goto previous/next diagnostic warning/error
	vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
	vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
end

local rust_opts = {
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		on_attach = rust_on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				procMacro = {
					enable = true,
				},
			},
		},
	},
}
require("lspconfig").tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").rust_analyzer.setup(rust_opts)
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

local file_exports = {}
file_exports.lsp_key_maps = lsp_key_maps
file_exports.lsp_formatting = lsp_formatting
file_exports.rust_opts = rust_opts
return file_exports
