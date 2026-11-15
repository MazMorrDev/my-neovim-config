local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpiar búsqueda" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Guardar" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Salir" })

-- Moverse entre ventanas
map("n", "<C-h>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ventana abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ventana arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana derecha" })

-- Mover líneas seleccionadas
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Bajar selección" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Subir selección" })

-- Diagnósticos
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Ver diagnóstico" })

-- Resaltar al copiar
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

-- Abrir la guía
map("n", "<leader>?", function()
  vim.cmd.edit(vim.fn.stdpath("config") .. "/GUIA.md")
end, { desc = "Abrir mi guía de Neovim" })
