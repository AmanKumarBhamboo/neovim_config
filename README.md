# Neovim Configuration

Personal Neovim setup with LSP, autocompletion, fuzzy finder, file explorer, terminal, git integration, and auto-formatting.

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Package manager |
| [vim-nightfly-guicolors](https://github.com/bluz71/vim-nightfly-guicolors) | Dark colorscheme |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippets |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting & indentation |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git gutter |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding popup |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Auto-formatting |
| [vim-dadbod](https://github.com/tpope/vim-dadbod) | Database client |
| [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) | Database browser UI |
| [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion) | Database completions |

## Keymaps

### General
| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `<leader>ww` | Save file |
| `<leader>q` | Quit file |

### Window Management
| Key | Action |
|---|---|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close current split |
| `<C-h>` | Move left |
| `<C-j>` | Move down |
| `<C-k>` | Move up |
| `<C-l>` | Move right |
| `<leader>wh` | Decrease width |
| `<leader>wl` | Increase width |
| `<leader>wj` | Decrease height |
| `<leader>wk` | Increase height |

### Buffer Navigation
| Key | Action |
|---|---|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |

### Telescope
| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fs` | Document symbols |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `gr` | References |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Open diagnostic float |

### Git (Gitsigns)
| Key | Action |
|---|---|
| `<leader>gb` | Git blame |
| `<leader>gp` | Preview hunk |
| `<leader>gn` | Next hunk |
| `<leader>gN` | Previous hunk |

### Terminal
| Key | Action |
|---|---|
| `<C-t>` | Toggle primary terminal |
| `<leader>tt` | Open a new terminal |
| `<Esc>` | Exit terminal mode → normal mode |
| `<leader>wh/j/k/l` | Resize from terminal mode |

### Database
| Key | Action |
|---|---|
| `:DB` | Run SQL query |
| `:DBUI` | Open database browser |

### Visual Mode
| Key | Action |
|---|---|
| `<` / `>` | Indent/outdent (keep selection) |
| `J` / `K` | Move lines down/up |
| `p` | Paste without overwriting register |
| `<leader>d` | Delete without yanking |

## LSP Servers (Mason)
Auto-installed: `lua_ls`, `pyright`, `ts_ls`, `sqls`, `rust_analyzer`

### LSP Commands
- `lua_ls` — enabled by default
- `:RustLsp` — enable rust-analyzer
- `:SqlsLsp` — enable sqls
- `:TsLsp` — enable ts_ls
- `:PyLsp` — enable pyright
- `:LspStatus` — show which servers are enabled

## Treesitter Parsers
Installed: lua, python, javascript, typescript, c, cpp, rust, sql

## Auto-formatting (conform.nvim)
Formats on save:
- Lua → `stylua`
- Python → `isort` + `black`
- JavaScript / TypeScript / JSX / TSX → `prettier`
- Rust → `rustfmt`
- C / C++ → `clang-format`
- SQL → `pg_format`
- All files → trim trailing whitespace
