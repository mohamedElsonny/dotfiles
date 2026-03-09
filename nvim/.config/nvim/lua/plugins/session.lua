return {
  "folke/persistence.nvim",
  lazy = false,
  opts = {
    branch = true, -- save separate sessions per git branch
  },
  config = function(_, opts)
    local persistence = require("persistence")
    persistence.setup(opts)

    -- Auto-restore session when opening Neovim with no arguments
    vim.api.nvim_create_autocmd("VimEnter", {
      nested = true,
      callback = function()
        -- Only restore if no files were passed as arguments
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          persistence.load()
        end
      end,
    })

    -- Detect stdin (piping into nvim)
    vim.api.nvim_create_autocmd("StdinReadPre", {
      callback = function()
        vim.g.started_with_stdin = true
      end,
    })
  end,
  keys = {
    { "<leader>Sr", function() require("persistence").load() end,                desc = "Restore session (cwd)" },
    { "<leader>Ss", function() require("persistence").select() end,              desc = "Select session" },
    { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>Sd", function() require("persistence").stop() end,                desc = "Stop session saving" },
  },
}
