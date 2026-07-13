return {
  "toppair/peek.nvim",
  build = "deno task --allow-all build",
  ft = { "markdown" },
  config = function()
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}
