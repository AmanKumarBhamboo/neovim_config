return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })

    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        git_status = {
          symbols = {
            added     = "A",
            deleted   = "D",
            modified  = "M",
            renamed   = "R",
            untracked = "?",
            ignored   = "!",
            unstaged  = "~",
            staged    = "+",
            conflict  = "!",
          },
        },
      },
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

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 then
          require("neo-tree.command").execute({ toggle = false })
        end
      end,
    })
  end,
}
