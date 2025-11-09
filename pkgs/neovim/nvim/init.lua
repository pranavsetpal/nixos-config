let = vim.g
set = vim.o
map = vim.keymap.set

-- Use colemak equivalent vim movement keys
map('', 'k', 'n'); map('', 'K', 'N')
map('', 'l', 'e'); map('', 'L', 'E')
map('', 'm', 'i'); map('', 'M', 'I')
map('', 'h', 'o'); map('', 'H', 'O')

map('', 'n', 'h'); map('', 'N', 'H')
map('', 'e', 'j'); map('', 'E', 'J')
map('', 'i', 'k'); map('', 'I', 'K')
map('', 'o', 'l'); map('', 'O', 'L')

-- Easy jumping between lines
map('', '<A-e>', '4j'); map('', '<A-i>', '4k')

-- Enable use of system clipboard
map('', "<A-y>", '"+y')
map('', "<A-p>", '"+p')

-- Show line numbers
set.number = true
set.relativenumber = true

-- Set tab length
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
-- set.noexpandtab = true
set.breakindent = true

-- Enable undo
set.undofile = true

-- Use terminal cursor
set.guicursor = ""

require("plugins")
require("lsp")
