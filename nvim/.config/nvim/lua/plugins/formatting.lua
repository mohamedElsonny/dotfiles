return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua             = { "stylua" },
        python          = { "ruff_format", "ruff_organize_imports" },
        javascript      = { "prettierd", "prettier", stop_after_first = true },
        typescript      = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json            = { "prettierd" },
        jsonc           = { "prettierd" },
        yaml            = { "prettierd" },
        html            = { "prettierd" },
        css             = { "prettierd" },
        markdown        = { "prettierd" },
        bash            = { "shfmt" },
        sh              = { "shfmt" },
        rust            = { "rustfmt" },
        ["_"]           = { "trim_whitespace" },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },
}
