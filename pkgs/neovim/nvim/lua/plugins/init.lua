local augroup = vim.api.nvim_create_augroup("most_basic_build_system", { clear = false })

vim.api.nvim_create_autocmd("PackChanged", {
	group = augroup,
	pattern = "*",
	callback = function(pack)
		local run_task = (pack.data or {}).run
		if ((pack.kind ~= "delete") and type(run_task) == "function") then
			pcall(run_task, pack.data)
		end
	end
})

require("plugins.midnight_nvim")
require("plugins.nvim-autopairs")
require("plugins.nvim-surround")
require("plugins.nvim-treesitter")
require("plugins.vimtex")
