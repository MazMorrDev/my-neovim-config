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
    },
  },
}
