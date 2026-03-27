return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = vim.keymap.set
          local buf = ev.buf
          local opts = function(desc) return { buffer = buf, desc = desc } end
          map("n", "gd",  vim.lsp.buf.definition,      opts("Go to definition"))
          map("n", "gD",  vim.lsp.buf.declaration,     opts("Go to declaration"))
          map("n", "gr",  vim.lsp.buf.references,      opts("References"))
          map("n", "gi",  vim.lsp.buf.implementation,  opts("Go to implementation"))
          map("n", "gy",  vim.lsp.buf.type_definition, opts("Go to type definition"))
          map("n", "K",   vim.lsp.buf.hover,           opts("Hover docs"))
          map("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
          map("n", "<leader>lr", vim.lsp.buf.rename,   opts("Rename symbol"))
          map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
          map("n", "<leader>lR", "<cmd>Telescope lsp_references<cr>",        opts("References"))
          map("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>",   opts("Implementations"))
          map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",  opts("Document symbols"))
          map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts("Workspace symbols"))
        end,
      })
      local servers = {
        "lua_ls", "ts_ls", "pyright", "ruff", "bashls",
        "jsonls", "yamlls", "cssls", "html", "dockerls", "marksman",
        "rust_analyzer",
      }
      vim.lsp.config("ruff", {
        on_attach = function(client, _)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end,
        init_options = {
          settings = {
            -- Let conform.nvim handle formatting
            organizeImports = false,
          },
        },
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
      local mason_registry = require("mason-registry")
      local server_to_package = {
        lua_ls = "lua-language-server", ts_ls = "typescript-language-server",
        pyright = "pyright", ruff = "ruff", bashls = "bash-language-server",
        jsonls = "json-lsp", yamlls = "yaml-language-server",
        cssls = "css-lsp", html = "html-lsp",
        dockerls = "dockerfile-language-server", marksman = "marksman",
        rust_analyzer = "rust-analyzer",
      }
      mason_registry.refresh(function()
        for _, pkg_name in pairs(server_to_package) do
          local ok, pkg = pcall(mason_registry.get_package, pkg_name)
          if ok and not pkg:is_installed() then pkg:install() end
        end
      end)
    end,
  },
}
