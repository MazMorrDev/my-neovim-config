return {
  {
    -- Renderiza el markdown dentro del mismo buffer (títulos, tablas, checkboxes, código)
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>cp", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Preview markdown (on/off)" },
    },
    opts = {
      latex = { enabled = false }, -- no usamos fórmulas LaTeX
      -- Mantener el preview también en la línea del cursor (no mostrar el código crudo al moverse)
      anti_conceal = { enabled = false },
      win_options = {
        -- Ocultar la sintaxis markdown en la línea del cursor en modo normal y comando
        concealcursor = { rendered = "nc" },
      },
    },
  },
}
