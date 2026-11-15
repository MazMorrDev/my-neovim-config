return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "tokyonight", globalstatus = true },
      extensions = { "neo-tree", "lazy", "mason" },
    },
  },
  {
    -- Pestañas arriba con los archivos abiertos (como en VS Code)
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Pestaña siguiente" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Pestaña anterior" },
      { "<leader>bd", "<cmd>bprevious | bdelete #<CR>", desc = "Cerrar pestaña" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Cerrar las demás" },
      { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Elegir pestaña" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "neo-tree", text = "Explorador", highlight = "Directory", separator = true } },
      },
    },
  },
  {
    -- Al pulsar <Espacio> muestra un menú con los atajos disponibles
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "Pestañas/Buffers" },
        { "<leader>c", group = "Código" },
        { "<leader>f", group = "Buscar" },
        { "<leader>g", group = "Git" },
      },
    },
  },
}
