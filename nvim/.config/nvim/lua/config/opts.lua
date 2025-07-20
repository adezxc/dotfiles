local g = vim.g
local opt = vim.opt

g.python_recommended_style = 1
g.rust_recommended_style= 1
opt.tabstop = 4
opt.smartindent = true
opt.shiftwidth = 4
opt.expandtab = true
vim.diagnostic.config({ virtual_text = true })
opt.undofile = true
