return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    -- Open harpoon quick menu in split-able window
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })
      end,
    })

    local map = vim.keymap.set

    map("n", "<leader>a", function() harpoon:list():add() end,
      { desc = "Harpoon add file" })
    map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon menu" })

    -- Quick file selection (1-5)
    map("n", "<leader>1", function() harpoon:list():select(1) end,
      { desc = "Harpoon file 1" })
    map("n", "<leader>2", function() harpoon:list():select(2) end,
      { desc = "Harpoon file 2" })
    map("n", "<leader>3", function() harpoon:list():select(3) end,
      { desc = "Harpoon file 3" })
    map("n", "<leader>4", function() harpoon:list():select(4) end,
      { desc = "Harpoon file 4" })
    map("n", "<leader>5", function() harpoon:list():select(5) end,
      { desc = "Harpoon file 5" })

    -- Cycle through harpoon list
    map("n", "<C-S-P>", function() harpoon:list():prev() end,
      { desc = "Harpoon prev file" })
    map("n", "<C-S-N>", function() harpoon:list():next() end,
      { desc = "Harpoon next file" })
  end,
}
