-- ==========================================
-- Leader Key
-- ==========================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- ==========================================
-- General
-- ==========================================
-- clear search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- save file
keymap.set("n", "<leader>ww", "<cmd>w<CR>")

-- quit file
keymap.set("n", "<leader>q", "<cmd>q<CR>")

-- ==========================================
-- Window Management
-- ==========================================
keymap.set("n", "<leader>sv", "<C-w>v")       -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")       -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")       -- make splits equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>") -- close current split

-- move between windows
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- resize windows
keymap.set("n", "<leader>wh", "<C-w><")
keymap.set("n", "<leader>wl", "<C-w>>")
keymap.set("n", "<leader>wj", "<C-w>-")
keymap.set("n", "<leader>wk", "<C-w>+")

-- navigate windows from terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-N>")
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- resize windows from terminal mode
keymap.set("t", "<leader>wh", "<C-\\><C-N><C-w><")
keymap.set("t", "<leader>wl", "<C-\\><C-N><C-w>>")
keymap.set("t", "<leader>wj", "<C-\\><C-N><C-w>-")
keymap.set("t", "<leader>wk", "<C-\\><C-N><C-w>+")

-- open a new terminal
keymap.set("n", "<leader>tt", function()
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({ direction = "horizontal" }):toggle()
end, { desc = "New terminal" })

-- ==========================================
-- Buffer Navigation
-- ==========================================
keymap.set("n", "<S-l>", "<cmd>bnext<CR>")
keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")

-- ==========================================
-- Indenting (keep selection after indent)
-- ==========================================
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- ==========================================
-- Move selected lines up/down
-- ==========================================
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ==========================================
-- Paste without overwriting register (visual mode)
-- ==========================================
keymap.set("v", "p", '"_dP')

-- ==========================================
-- Delete without yanking
-- ==========================================
keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- ==========================================
-- Markdown Preview
-- ==========================================
keymap.set("n", "<leader>mp", "<cmd>PeekOpen<CR>", { desc = "Markdown preview" })
keymap.set("n", "<leader>mc", "<cmd>PeekClose<CR>", { desc = "Close markdown preview" })


