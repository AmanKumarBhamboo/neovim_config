return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      lsp_trouble = true,
      gitsigns = true,
      telescope = true,
      nvimtree = true,
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
