return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Tokyonight con la paleta cambiada a tonos rojos
      require("tokyonight").setup({
        style = "night",
        on_colors = function(c)
          local util = require("tokyonight.util")

          -- Fondos negros (sin tinte)
          c.bg = "#0a0a0a"
          c.bg_dark = "#050505"
          c.bg_dark1 = "#000000"
          c.bg_highlight = "#1a1a1a"
          c.fg = "#f2dcdc"
          c.fg_dark = "#c99a9e"
          c.fg_gutter = "#4a2328"
          c.dark3 = "#6b3a40"
          c.dark5 = "#94636a"
          c.comment = "#8a5a60"
          c.terminal_black = "#3d2024"

          -- Acentos: el rojo manda, acompañado de tonos cálidos afines
          -- (frambuesa, orquídea, naranja, ámbar, dorado, melocotón y rosa)
          c.red = "#ff4d4d" -- builtins, etiquetas
          c.red1 = "#d11a2a" -- errores
          c.blue = "#ff6b6b" -- funciones (rojo)
          c.purple = "#ff3e7f" -- palabras clave (frambuesa)
          c.magenta = "#e05fc4" -- sentencias, constructores (orquídea)
          c.magenta2 = "#ff2e88"
          c.blue1 = "#ffb454" -- tipos (ámbar)
          c.cyan = "#ff8f66" -- imports / preprocesador (naranja claro)
          c.orange = "#ff8c3a" -- constantes y números (naranja)
          c.yellow = "#ffd479" -- parámetros, avisos (dorado)
          c.green = "#f7c59f" -- strings (melocotón)
          c.green1 = "#ff9eb5" -- propiedades (rosa)
          c.green2 = "#b8475a"
          c.teal = "#f78fb3" -- pistas (rosa)
          c.blue2 = "#ffa07a" -- info (salmón)
          c.blue5 = "#d9a3a3" -- operadores y puntuación (rosa apagado)
          c.blue6 = "#ffd6c2"
          c.blue0 = "#6b1a24" -- selección / búsqueda
          c.blue7 = "#4d1a21"
          c.git = { add = "#9ccc7a", change = "#ff9f5a", delete = "#ff3b3b", ignore = c.dark3 }

          -- Recalcular los colores derivados (tokyonight los calcula antes de on_colors)
          local blend = function(hex, amount)
            return util.blend(hex, amount, c.bg)
          end
          c.black = util.blend(c.bg, 0.8, "#000000")
          c.border = c.black
          c.border_highlight = blend(c.blue1, 0.8)
          c.bg_popup = c.bg_dark
          c.bg_statusline = c.bg_dark
          c.bg_sidebar = c.bg_dark
          c.bg_float = c.bg_dark
          c.bg_visual = blend(c.blue0, 0.6)
          c.bg_search = c.blue0
          c.fg_sidebar = c.fg_dark
          c.fg_float = c.fg
          c.error = c.red1
          c.todo = c.blue
          c.warning = c.yellow
          c.info = c.blue2
          c.hint = c.teal
          c.diff = {
            add = blend(c.git.add, 0.15),
            delete = blend(c.red1, 0.3),
            change = blend(c.orange, 0.12),
            text = blend(c.orange, 0.3),
          }
          c.rainbow = { c.red, c.orange, c.magenta, c.yellow, c.purple, c.cyan, c.green, c.blue }

          -- Colores de :terminal
          c.terminal = {
            black = c.black,
            black_bright = c.terminal_black,
            red = c.red,
            red_bright = "#ff6b6b",
            green = c.git.add,
            green_bright = "#b5e09a",
            yellow = c.yellow,
            yellow_bright = "#ffc9a0",
            blue = c.blue,
            blue_bright = c.blue2,
            magenta = c.magenta,
            magenta_bright = c.magenta2,
            cyan = c.cyan,
            cyan_bright = c.blue6,
            white = c.fg_dark,
            white_bright = c.fg,
          }
        end,
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.red, bold = true }
          hl.LineNr = { fg = c.dark3 }
          hl.WinSeparator = { fg = c.red1 }
          hl.FloatBorder = { fg = c.red, bg = c.bg_float }
        end,
      })
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
