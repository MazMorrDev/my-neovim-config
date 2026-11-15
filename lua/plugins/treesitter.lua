-- Resaltado de sintaxis preciso. Requiere el CLI `tree-sitter` para compilar parsers.
local parsers = {
  -- web / Angular / Playwright
  "javascript", "typescript", "tsx", "angular", "html", "css", "scss", "json", "jsdoc",
  -- .NET
  "c_sharp", "xml",
  -- Rust / Kotlin
  "rust", "toml", "kotlin",
  -- varios
  "yaml", "bash", "dockerfile", "sql", "lua", "markdown", "markdown_inline", "regex",
  "gitcommit", "git_rebase", "gitignore", "diff",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(parsers)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
