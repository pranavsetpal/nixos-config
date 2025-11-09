vim.pack.add({{ src = "https://github.com/windwp/nvim-autopairs" }})

local nvim_autopairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local conds = require("nvim-autopairs.conds")

function expand_within_rule(a1, ins, a2, lang)
  nvim_autopairs.add_rule(
    rule(ins, ins, lang)
      :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
      :with_move(conds.none())
      :with_cr(conds.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
      end)
  )
end

nvim_autopairs.setup({
	check_ts = true;
})

nvim_autopairs.add_rules({
	rule("\\(", "\\)", { "tex", "latex" })
	:with_pair(conds.not_after_regex("%%")),

	rule("\\[", "\\]", { "tex", "latex" })
	:with_pair(conds.not_after_regex("%%")),

	expand_within_rule("(", " ",")"),
	expand_within_rule("[", " ","]"),
	expand_within_rule("{", " ","}"),
	expand_within_rule("<", " ",">"),
	expand_within_rule("\\(", " ","\\)"),
	expand_within_rule("\\[", " ","\\]"),
	expand_within_rule("\"", " ","\""),
	expand_within_rule("\'", " ","\'"),
})
