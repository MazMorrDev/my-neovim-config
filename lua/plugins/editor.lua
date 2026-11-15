return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto en el proyecto" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Archivos abiertos" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Archivos recientes" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Ayuda de nvim" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Errores/avisos" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Todos los atajos" },
      { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules/", "%.git/", "target/", "bin/", "obj/", "build/" },
          mappings = { i = { ["<Esc>"] = require("telescope.actions").close } }, -- Esc cierra directo
        },
        pickers = { find_files = { hidden = true } },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  -- Detecta si el archivo usa tabs o 2/4 espacios (respeta .editorconfig)
  { "NMAC427/guess-indent.nvim", event = "BufReadPre", opts = {} },
}
