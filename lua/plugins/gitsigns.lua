return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local keymap = vim.keymap

        keymap.set("n", "<leader>gb", gitsigns.blame_line, { buffer = bufnr, desc = "Git blame" })
        keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr, desc = "Next hunk" })
        keymap.set("n", "<leader>gN", gitsigns.prev_hunk, { buffer = bufnr, desc = "Prev hunk" })
      end,
    })
  end,
}
