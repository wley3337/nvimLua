local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
	print("Error loading rust-tools")
	return
end

--[[ local function on_attach(client, buffer) ]]
--[[ 	-- This callback is called when the LSP is atttached/enabled for this buffer ]]
--[[ 	-- we could set keymaps related to LSP, etc here. ]]
--[[ 	local keymap_opts = { buffer = buffer } ]]
--[[ 	-- Code navigation and shortcuts ]]
--[[ 	vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts) ]]
--[[ 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts) ]]
--[[ end ]]

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration

rt.setup(
	require("user.native-lsp").rust_opts
	--[[   { ]]
	--[[   server = { ]]
	--[[     on_attach = function(_, bufnr) ]]
	--[[       -- Hover actions ]]
	--[[       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr }) ]]
	--[[       -- Code action groups ]]
	--[[       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr }) ]]
	--[[     end, ]]
	--[[   }, ]]
	--[[ } ]]
)
