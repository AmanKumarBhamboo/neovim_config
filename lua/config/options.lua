local opt = vim.opt --for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true


--tabs and intendation 
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping 
opt.wrap = false

-- search settings

opt.ignorecase = true
opt.smartcase = true

-- apperance 
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace 
opt.backspace = "indent,eol,start"

-- clipboard 
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.timeoutlen = 500

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.timeoutlen = 0
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.timeoutlen = 500
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:t",
  callback = function()
    vim.opt.timeoutlen = 0
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "t:*",
  callback = function()
    vim.opt.timeoutlen = 500
  end,
})
