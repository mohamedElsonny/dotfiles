return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    event = "VeryLazy",
    init = function()
      -- Close neo-tree sidebar when a Claude diff opens
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("ClaudeDiffCloseNeotree", { clear = true }),
        callback = function(ev)
          if vim.b[ev.buf].claudecode_diff_tab_name then
            pcall(vim.cmd, "Neotree close")
          end
        end,
      })
    end,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude Code" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
      {
        "<leader>aD",
        function()
          local server = require("claudecode.server.init")
          local port = server.state.port
          if not port then
            vim.notify("Claude Code server not running", vim.log.levels.ERROR)
            return
          end
          local cmd = string.format(
            "CLAUDE_CODE_SSE_PORT=%s ENABLE_IDE_INTEGRATION=true FORCE_CODE_TERMINAL=true claude --dangerously-skip-permissions",
            port
          )
          vim.fn.jobstart({ "tmux", "split-window", "-h", "-l", "30%", cmd }, { detach = true })
        end,
        desc = "Toggle Claude Code (dangerous)",
      },
    },
    opts = {
      diff_opts = {
        open_in_new_tab = true,
        hide_terminal_in_new_tab = true,
      },
      terminal = {
        provider = "external",
        provider_opts = {
          external_terminal_cmd = function(cmd, env)
            local env_str = ""
            for k, v in pairs(env) do
              env_str = env_str .. k .. "=" .. v .. " "
            end
            return { "tmux", "split-window", "-h", "-l", "30%", env_str .. cmd }
          end,
        },
      },
    },
  },
}
