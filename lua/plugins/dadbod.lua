return {
  {
    "tpope/vim-dadbod",
    init = function()
      vim.g.dbs = {
        "postgresql://apple@localhost:5432/postgres",
        "postgresql://apple@localhost:5432/airplane",
        "postgresql://apple@localhost:5432/amazon_retail",
        "postgresql://apple@localhost:5432/lapd_crime",
        "postgresql://apple@localhost:5432/olist",
        "postgresql://apple@localhost:5432/tpc",
      }
      vim.g.db_ui_use_nerd_fonts = true
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
  },
}
