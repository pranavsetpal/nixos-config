local let = vim.g
local set = vim.o
local map = vim.keymap.set
local hi = vim.api.nvim_set_hl


map('', 'k', 'n'); map('', 'K', 'N')
map('', 'l', 'e'); map('', 'L', 'E')
map('', 'm', 'i'); map('', 'M', 'I')
map('', 'h', 'o'); map('', 'H', 'O')

map('', 'n', 'h'); map('', 'N', 'H')
map('', 'e', 'j'); map('', 'E', 'J')
map('', 'i', 'k'); map('', 'I', 'K')
map('', 'o', 'l'); map('', 'O', 'L')

map('', '<A-e>', '4j'); map('', '<A-i>', '4k')

-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Set tab length
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.noexpandtab = true
set.breakindent = true

-- Use terminal cursor
set.guicursor = false

-- Show line numbers
set.number = true
set.relativenumber = true
