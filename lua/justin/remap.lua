-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set <space> as the leader key
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move Highlight section
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep in middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Tmux
vim.keymap.set('n', '<leader>ts', '<cmd>silent !tmux neww tmux-sessionizer<CR>', opts)

vim.keymap.set('n', '<leader>dp', '<cmd>silent !dprint fmt %<CR>', opts)

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- EXIT Gdiff
keymap('n', '<C-q>', '<C-w><C-o>', opts)

-- Open Diffview
keymap('n', '<leader>do', ':DiffviewOpen<CR>', opts)
keymap('n', '<leader>dc', ':DiffviewClose<CR>', opts)
keymap('n', '<leader>df', ':DiffviewFile %<CR>', opts)

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-tab>', '<c-6>', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

keymap('n', '<leader>tw', ':silent !tmux neww -d -n "$(basename $(pwd))"<CR>', opts)

-- Sort lines
keymap('v', '<leader>s', ':sort<CR>', opts)

-- LazyGit
keymap('n', '<leader>lg', ':silent LazyGit<CR>', opts)
