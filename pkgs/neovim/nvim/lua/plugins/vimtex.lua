local let = vim.g

vim.pack.add({"https://github.com/lervag/vimtex"})

let.vimtex_view_method = "zathura"
let.vimtex_syntax_enabled = 0
let.vimtex_compiler_latexmk = { options = {
  "-shell-escape",
  "-verbose",
  "-file-line-error",
  "-synctex=1",
  "-interaction=nonstopmode",
}}
