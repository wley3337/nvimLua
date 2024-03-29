local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("Error loading null-ls")
	return
end
-- Null LS is intended to be a layer to attach things like formatters and linters to nvim's native lsp
-- https://github.com/jose-e/Users/hal/.cargo/binlias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- use <:NullLsInfo> to see what sources are being used
null_ls.setup({
	debug = false,
	sources = {
		-- Settings here will override project level files like .prettierrc
		-- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
		formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		-- formatting.yapf,
		formatting.stylua,
		formatting.rustfmt,
		diagnostics.flake8,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		end
	end,
})
