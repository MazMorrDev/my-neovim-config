-- Servidores de lenguaje (LSP): autocompletado, errores, ir a definición, renombrar…
-- Mason los instala en ~/.local/share/nvim/mason (sin sudo). Ver con :Mason
local servers = {
  "ts_ls",       -- JavaScript / TypeScript (Playwright, Angular)
  "angularls",   -- plantillas y componentes Angular
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "lua_ls",      -- para editar esta misma configuración
  "kotlin_lsp",  -- Kotlin (LSP oficial de JetBrains)
}
local tools = { "prettier" }

-- C# solo si está instalado el SDK de .NET
if vim.fn.executable("dotnet") == 1 then
  table.insert(servers, "csharp_ls")
end

return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = { preset = "default" }, -- <C-y> acepta, <C-n>/<C-p> navegan, <C-space> abre
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true },
      sources = { default = { "lsp", "path", "buffer" } },
    },
  },
  { "mason-org/mason.nvim", cmd = "Mason", opts = { ui = { border = "rounded" } } },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Rust: se usa el rust-analyzer de rustup, no el de Mason
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
            cargo = { allFeatures = true },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")

      vim.lsp.config("lua_ls", {
        settings = { Lua = { workspace = { checkThirdParty = false }, diagnostics = { globals = { "vim" } } } },
      })

      -- Activa automáticamente todo servidor instalado con Mason
      require("mason-lspconfig").setup({ automatic_enable = { exclude = { "rust_analyzer" } } })
      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.deepcopy(servers), tools),
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Ir a definición")
          map("gr", "<cmd>Telescope lsp_references<CR>", "Ver referencias")
          map("gI", vim.lsp.buf.implementation, "Ir a implementación")
          map("<leader>ca", vim.lsp.buf.code_action, "Acciones (quick fix)")
          map("<leader>cr", vim.lsp.buf.rename, "Renombrar símbolo")
          map("<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", "Símbolos del archivo")
        end,
      })
    end,
  },
  {
    -- Formateo: prettier para web (usa el del proyecto si existe), LSP para el resto
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Formatear archivo" },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" }, typescript = { "prettier" },
        javascriptreact = { "prettier" }, typescriptreact = { "prettier" },
        html = { "prettier" }, htmlangular = { "prettier" },
        css = { "prettier" }, scss = { "prettier" },
        json = { "prettier" }, jsonc = { "prettier" }, yaml = { "prettier" },
      },
      default_format_opts = { lsp_format = "fallback" },
      -- Formatear al guardar: descomenta la línea de abajo si lo quieres
      -- format_on_save = { timeout_ms = 1000 },
    },
  },
}
