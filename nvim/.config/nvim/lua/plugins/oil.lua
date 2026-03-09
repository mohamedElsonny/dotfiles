return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- oil docs recommend against lazy loading, but since we only use it via
  -- the "-" keymap (neo-tree remains the default file explorer), this is safe
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
  },
  cmd = "Oil",
  opts = {
    -- neo-tree already handles directory browsing
    default_file_explorer = false,
    columns = { "icon" },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      natural_order = "fast",
      is_always_hidden = function(name)
        return name == ".." or name == ".git"
      end,
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "rounded",
    },
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      -- Disable defaults that conflict with vim-tmux-navigator
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-s>"] = false,
    },
  },
}
