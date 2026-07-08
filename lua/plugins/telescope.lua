return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
  end,
}
