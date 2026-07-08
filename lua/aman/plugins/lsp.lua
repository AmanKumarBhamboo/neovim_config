local keymap = vim.keymap

-- Mason: auto-install LSP servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "sqls" },
})

-- Override Lua LS config for Neovim runtime
vim.lsp.config.lua_ls = vim.tbl_deep_extend("force", vim.lsp.config.lua_ls or {}, {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
})

-- nvim-cmp: autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
    { name = "vim-dadbod-completion" },
  }),
})
