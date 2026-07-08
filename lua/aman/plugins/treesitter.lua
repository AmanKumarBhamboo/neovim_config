require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "python", "javascript", "typescript",
    "c", "cpp", "rust", "go",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
