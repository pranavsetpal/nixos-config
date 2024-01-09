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

-- Enable system clipboard with Ctrl+p/y
map('', "<C-y>", '"+y')
map('', "<C-p>", '"+p')


-- vim.cmd("packadd packer.nvim")
-- require("packer").startup(function(use)
-- 	use{"wbthomason/packer.nvim"} -- Plugin manager
--
-- 	--- Visuals
-- 	use("navarasu/onedark.nvim") -- Onedark Colorscheme
-- 	use{"sheerun/vim-polyglot"} -- Extended syntax highlighting support
-- 	use{"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}
--
-- 	--- Editing
-- 	use{"alvan/vim-closetag"} -- Autoclose HTML tags
-- 	use{"raimondi/delimitmate"} -- Autoclose and manage brackets/quotes
-- 	use{"tpope/vim-surround"} -- Allow quickly change brackets,quotes,tags
-- 	use{"tomtom/tcomment_vim"} -- Comment shortcut
--
-- 	--- More than just text editor
-- 	use{"RaafatTurki/hex.nvim"} -- Hex/Binary Support
-- 	use{"lervag/vimtex"} -- LaTeX Support
-- 	-- (Upcoming) Markdown Support
--
-- 	---Lsp
-- 		use{"neovim/nvim-lspconfig"}
-- 		use{"williamboman/mason.nvim", run=":MasonUpdate"} -- LSP Client Manager
-- 		-- Auto completion
-- 		use{"hrsh7th/nvim-cmp"}
-- 		use{"hrsh7th/cmp-nvim-lsp"}
-- 		use{"hrsh7th/cmp-path"} -- Directory Support
-- end)


-- Onedark: Colorscheme
require("onedark").setup({
	style = "darker",

	colors = {
		bg0 = "#030508",
		bg1 = "#0c0e13",
		bg2 = "#141619",
		bg3 = "#17161b",
		bg_d = "#000000"
	},
})
require("onedark").load()

require("nvim-treesitter.configs").setup({
	ensure_installed = { "bash", "c", "nix", "python", "zig" },
	highlight = { enable = true }
})


-- Show line numbers and highlight current line
set.number = true
set.relativenumber = true

hi(0, "TabLine", { fg="#a0a0a0" })
hi(0, "TabLineSel", { fg="#e7e7e7", bg="#171717" })


-- require("mason").setup()
require("hex").setup()


-- Set tab length
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.noexpandtab = true
set.breakindent = true

-- Change cursor
set.guicursor = false

-- Auto close
let.delimitMate_expand_cr = 2
let.delimitMate_expand_space = 1
let.delimitMate_expand_inside_quotes = 1


-- Vimtex
let.vimtex_view_method = "zathura"
-- let.vimtex_mappings_prefix = "<Tab>"
set.conceallevel=1
let.tex_conceal='abdmg'

-- LSP
local lsp = require("lspconfig")
local cmp = require("cmp")

lsp.clangd.setup{}
lsp.ruff_lsp.setup{
	filetypes = { "python", "sage" }
}
lsp.gopls.setup{}
lsp.zls.setup{}

cmp.setup({
	snippet = {
		expand = function(args)
		end,
	},
	mapping = {
		["<C-A-e>"] = cmp.mapping.scroll_docs(4),
		["<C-A-i>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.select_next_item(),
		["<C-i>"] = cmp.mapping.select_prev_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-n>"] = cmp.mapping.abort(),
		["<C-o>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 6, max_item_count = 8 },
		{ name = "path" }
	},
	view = {
		entries = {
			name = "custom",
			selection_order = "near_cursor",
		}
	},
	experimental = {
		ghost_text = true,
	},
})
vim.diagnostic.disable()
