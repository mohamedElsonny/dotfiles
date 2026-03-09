return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp",
      "TmuxNavigateRight", "TmuxNavigatePrevious", "TmuxNavigatorProcessList",
    },
    keys = {
      { "<C-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>",     mode = { "n", "t" }, desc = "Navigate left" },
      { "<C-j>",  "<cmd><C-U>TmuxNavigateDown<cr>",     mode = { "n", "t" }, desc = "Navigate down" },
      { "<C-k>",  "<cmd><C-U>TmuxNavigateUp<cr>",       mode = { "n", "t" }, desc = "Navigate up" },
      { "<C-l>",  "<cmd><C-U>TmuxNavigateRight<cr>",    mode = { "n", "t" }, desc = "Navigate right" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", mode = { "n", "t" }, desc = "Navigate previous" },
    },
  },
}
