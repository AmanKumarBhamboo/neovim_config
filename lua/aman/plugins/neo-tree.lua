local neo_tree = require("neo-tree")

neo_tree.setup({
  close_if_last_window = true,
  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_current",
  },

  window = {
    mappings = {
      ["<Space>"] = "none",
    },
  },
})

-- Auto-open neo-tree when nvim starts in a directory (no file argument)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ toggle = false })
    end
  end,
})
