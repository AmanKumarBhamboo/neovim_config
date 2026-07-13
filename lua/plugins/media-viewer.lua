return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    dir = ".",
    name = "media-viewer",
    config = function()
      local function open_in_system()
        local file = vim.fn.expand("%:p")
        if vim.fn.filereadable(file) == 1 then
          vim.fn.jobstart({ "open", file }, { detach = true })
          vim.notify("Opening: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
        else
          vim.notify("File not found: " .. file, vim.log.levels.ERROR)
        end
      end

      local function open_media_under_cursor()
        local line = vim.api.nvim_get_current_line()
        local file = line:match("(%S+%.%w+)")
        if file and vim.fn.filereadable(file) == 1 then
          vim.fn.jobstart({ "open", file }, { detach = true })
          vim.notify("Opening: " .. file, vim.log.levels.INFO)
        else
          vim.notify("No valid file found under cursor", vim.log.levels.WARN)
        end
      end

      vim.api.nvim_create_user_command("OpenInSystem", open_in_system, { desc = "Open current file in system viewer" })
      vim.api.nvim_create_user_command("OpenMediaUnderCursor", open_media_under_cursor, { desc = "Open media file under cursor" })

      local keymap = vim.keymap
      keymap.set("n", "<leader>oo", open_in_system, { desc = "Open file in system viewer" })
      keymap.set("n", "<leader>ou", open_media_under_cursor, { desc = "Open media under cursor" })

      local media_group = vim.api.nvim_create_augroup("MediaViewer", { clear = true })

      vim.api.nvim_create_autocmd("BufReadPost", {
        group = media_group,
        pattern = { "*.mp4", "*.mov", "*.avi", "*.mkv", "*.webm" },
        callback = function()
          vim.notify("Video detected. Press <leader>oo to open in system player", vim.log.levels.INFO)
        end,
      })

      vim.api.nvim_create_autocmd("BufReadPost", {
        group = media_group,
        pattern = { "*.pdf" },
        callback = function()
          vim.notify("PDF detected. Press <leader>oo to open in system viewer", vim.log.levels.INFO)
        end,
      })
    end,
  },
}
