return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "sqls", "rust_analyzer", "dockerls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local keymap = vim.keymap

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      }

      vim.lsp.config.rust_analyzer = {
        autostart = false,
        settings = {
          rust_analyzer = {
            checkOnSave = { command = "clippy" },
          },
        },
      }

      for _, server in ipairs({ "pyright", "ts_ls", "sqls", "dockerls" }) do
        vim.lsp.config[server] = { autostart = false }
      end

      local enabled_servers = { lua_ls = true }

      local server_commands = {
        RustLsp = "rust_analyzer",
        SqlsLsp = "sqls",
        TsLsp = "ts_ls",
        PyLsp = "pyright",
        DockerLsp = "dockerls",
      }

      for cmd, server in pairs(server_commands) do
        vim.api.nvim_create_user_command(cmd, function()
          if not enabled_servers[server] then
            vim.lsp.enable(server)
            enabled_servers[server] = true
            vim.notify(server .. " enabled", vim.log.levels.INFO)
          else
            vim.notify(server .. " is already enabled", vim.log.levels.WARN)
          end
        end, {})
      end

      vim.api.nvim_create_user_command("LspStatus", function()
        local status = {}
        for cmd_name, server in pairs(server_commands) do
          table.insert(status, server .. ": " .. (enabled_servers[server] and "ON" or "OFF"))
        end
        vim.notify(table.concat(status, "\n"), vim.log.levels.INFO)
      end, {})

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
          keymap.set("n", "<leader>df", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
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
    end,
  },
}
