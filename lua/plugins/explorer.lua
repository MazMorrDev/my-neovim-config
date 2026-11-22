-- Explorador de archivos lateral con íconos y estado de git

-- Colores de carpeta por nombre, imitando "Material Icon Theme" de VS Code
local folder_colors = {
  default = "#90a4ae", -- carpeta genérica (gris azulado)
  src = "#4caf50", source = "#4caf50",
  lib = "#c0ca33", libs = "#c0ca33", components = "#c0ca33",
  lua = "#42a5f5", scripts = "#42a5f5", ["script"] = "#42a5f5",
  test = "#00bfa5", tests = "#00bfa5", __tests__ = "#00bfa5", spec = "#00bfa5", e2e = "#00bfa5",
  docs = "#0288d1", doc = "#0288d1",
  config = "#00acc1", configs = "#00acc1", [".config"] = "#00acc1",
  plugins = "#ff7043", plugin = "#ff7043",
  node_modules = "#8bc34a",
  [".git"] = "#f4511e", [".github"] = "#546e7a", [".vscode"] = "#2196f3", [".claude"] = "#d97757",
  public = "#039be5", assets = "#ffb300", images = "#26a69a", img = "#26a69a", icons = "#26a69a",
  styles = "#ab47bc", css = "#42a5f5",
  utils = "#fbc02d", helpers = "#fbc02d", api = "#ffb300", services = "#ffb300",
  dist = "#e53935", build = "#e53935", out = "#e53935", target = "#e53935", bin = "#e53935",
  tmp = "#9e9e9e", temp = "#9e9e9e", vendor = "#9e9e9e",
}

local function folder_hl(name)
  return "NeoTreeMaterialFolder_" .. name:gsub("[^%w]", "_")
end

local function set_folder_highlights()
  for name, color in pairs(folder_colors) do
    vim.api.nvim_set_hl(0, folder_hl(name), { fg = color })
  end
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- para que `nvim .` abra el explorador directamente
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "DaikyXendo/nvim-material-icon",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal<CR>", desc = "Explorador (abrir/cerrar)" },
      { "<leader>o", "<cmd>Neotree focus<CR>", desc = "Ir al explorador" },
      { "<leader>gs", "<cmd>Neotree float git_status<CR>", desc = "Archivos modificados (git)" },
    },
    init = function()
      set_folder_highlights()
      -- Un cambio de tema borra los highlights: volver a crearlos
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_folder_highlights })
    end,
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        icon = {
          folder_closed = vim.fn.nr2char(0xF024B), -- 󰉋 carpeta (Material Design)
          folder_open = vim.fn.nr2char(0xF0770), -- 󰝰 carpeta abierta
          provider = function(icon, node)
            if node.type == "directory" then
              local name = node.name:lower()
              icon.highlight = folder_hl(folder_colors[name] and name or "default")
            elseif node.type == "file" or node.type == "terminal" then
              -- Archivos: iconos de nvim-material-icon (igual que el proveedor por defecto)
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if ok then
                local text, hl = devicons.get_icon(node.type == "terminal" and "terminal" or node.name)
                icon.text = text or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
        },
      },
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
