return {
  {
    "nickjvandyke/opencode.nvim",
    keys = {
      { "<leader>oa", function() require("opencode").ask() end, desc = "OpenCode Ask" },
      { "<leader>oa", function() require("opencode").ask() end, mode = "v", desc = "OpenCode Ask (selection)" },
      { "<leader>os", function() require("opencode").select() end, desc = "OpenCode Select" },
      { "<leader>op", function() require("opencode").operator() end, desc = "OpenCode Operator" },
    },
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*opencode*",
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
          vim.keymap.set("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
          vim.keymap.set("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
          vim.keymap.set("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
        end,
      })
    end,
  },
}
