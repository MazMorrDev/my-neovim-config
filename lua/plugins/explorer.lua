-- Explorador de archivos lateral con íconos y estado de git
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- para que `nvim .` abra el explorador directamente
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal<CR>", desc = "Explorador (abrir/cerrar)" },
      { "<leader>o", "<cmd>Neotree focus<CR>", desc = "Ir al explorador" },
      { "<leader>gs", "<cmd>Neotree float git_status<CR>", desc = "Archivos modificados (git)" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        follow_current_file = { enabled = true }, -- marca el archivo que estás editando
        use_libuv_file_watcher = true,            -- se refresca solo si cambias archivos desde la terminal
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          visible = true,          -- muestra ocultos/ignorados, pero atenuados
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = { ".git" },
        },
      },
      window = {
        width = 34,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none", -- deja libre la tecla leader
        },
      },
    },
  },
}
