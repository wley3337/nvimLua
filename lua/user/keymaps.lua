local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- native in the key map
-- New in nvim v.7
-- in normal mode ( "n" ) map "K", run command, only for this buffer { buffer =0}
-- vim.keymap.set("n", "K", vim.lsp.buff.hover, { buffer = 0 })
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--- ':Telescope keymaps' for a searchable list of your keymaps
-- NORMAL --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Move through soft-wrapped spaces
keymap("n", "j", "v:count ? 'j': 'gj'", { expr = true })
keymap("n", "k", "v:count ? 'k': 'gk'", { expr = true })

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- keymap("n", "<leader>e", ":E <CR>", opts) -- nvim native file explorer

-- Yank entire line
-- keymap("n", "Y", "y", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertial resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Treesitter --
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fb", ":Telescope file_browser<cr>", opts)
--[[ keymap("n", "<leader>fif", "<cmd>lua require('telescope.builtin').()<cr>", opts) ]]
keymap("n", "<leader>fff", "<cmd>lua require('user.custom_functions').curr_buf_fzf()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fr", "<cmd>lua require'telescope.builtin'.buffers()<cr>", opts)
-- FORMATTING --
keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", opts)

-- INSERT --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- VISUAL --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Comment
-- Mappings in setup function in comment.lua

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- doesn't replace register with what you pasted on top of
keymap("v", "p", '"_dP', opts)

-- VISUAL BLOCK --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- DAP ---
keymap("n", "<F1>", ": lua require('dap').continue()<cr>", opts)
keymap("n", "<F2>", "<cmd>lua require('dap').step_into()<cr>", opts)
keymap("n", "<F3>", "<cmd>lua require('dap').step_over()<cr>", opts)
keymap("n", "<F4>", "<cmd>lua require('dap').step_out()<cr>", opts)
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>BP", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
keymap(
	"n",
	"<leader>lp ",
	"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	opts
)
keymap("n", "<leader>dr ", "<cmd>lua require'dap'.repl.open()<cr>", opts)
keymap("n", "<leader>dl ", "<cmd>lua require('dap').run_last()<cr>", opts)
-- GitSigns --
keymap("n", "<leader>gb", ":GitBlameToggle<cr>", opts)
-- TERMINAL --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
