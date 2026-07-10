local M = {}

local quotes_file = vim.fn.stdpath("config") .. "/quotes.txt"
local timer = nil
local win_id = nil
local buf_id = nil
local uv = vim.uv

local fallback_quotes = {
  { text = "The only way to do great work is to love what you do.", author = "Steve Jobs" },
  { text = "Simplicity is the ultimate sophistication.", author = "Leonardo da Vinci" },
  { text = "First, solve the problem. Then, write the code.", author = "John Johnson" },
}

local function parse_quotes()
  local file = io.open(quotes_file, "r")
  if not file then
    return fallback_quotes
  end

  local quotes = {}
  for line in file:lines() do
    local text, author = line:match("^\"(.+)\"%s*—%s*(.+)$")
    if text and author then
      table.insert(quotes, { text = text, author = author })
    end
  end
  file:close()

  return #quotes > 0 and quotes or fallback_quotes
end

local function pick_random(quotes)
  return quotes[math.random(#quotes)]
end

local function create_window()
  if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
    vim.api.nvim_buf_delete(buf_id, { force = true })
  end

  buf_id = vim.api.nvim_create_buf(false, true)

  local editor_width = vim.o.columns
  local win_width = math.min(60, editor_width - 42)

  local opts = {
    relative = "editor",
    width = win_width,
    height = 1,
    row = 0,
    col = editor_width - win_width,
    style = "minimal",
    border = "none",
    focusable = false,
    zindex = 100,
  }

  win_id = vim.api.nvim_open_win(buf_id, false, opts)
  vim.wo[win_id].winblend = 0
  vim.wo[win_id].wrap = false
end

local function display_quote()
  if not buf_id or not vim.api.nvim_buf_is_valid(buf_id) then
    create_window()
  end

  local quotes = parse_quotes()
  local q = pick_random(quotes)

  local editor_width = vim.o.columns
  local win_width = math.min(60, editor_width - 42)
  local quote_line = "\"" .. q.text .. "\" — " .. q.author

  local function right_align(text)
    local padding = win_width - vim.fn.strdisplaywidth(text)
    if padding > 0 then
      return string.rep(" ", padding) .. text
    end
    return text
  end

  local lines = {
    right_align(quote_line),
  }

  vim.bo[buf_id].modifiable = true
  vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  vim.bo[buf_id].modifiable = false

  local ns = vim.api.nvim_create_namespace("quote_widget")
  vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)
  vim.api.nvim_buf_add_highlight(buf_id, ns, "Comment", 0, 0, -1)
end

function M.start()
  math.randomseed(os.time())
  create_window()
  display_quote()

  timer = uv.new_timer()
  timer:start(10000, 10000, vim.schedule_wrap(function()
    if win_id and vim.api.nvim_win_is_valid(win_id) then
      display_quote()
    else
      create_window()
      display_quote()
    end
  end))
end

function M.stop()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, true)
    win_id = nil
  end
end

M.start()

return M
