return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
        end
        map("]h", function() gs.nav_hunk("next") end, "Siguiente cambio")
        map("[h", function() gs.nav_hunk("prev") end, "Cambio anterior")
        map("<leader>gp", gs.preview_hunk, "Ver cambio")
        map("<leader>gr", gs.reset_hunk, "Deshacer cambio")
        map("<leader>gb", gs.blame_line, "Blame de la línea")
        map("<leader>gB", gs.toggle_current_line_blame, "Blame siempre visible")
        map("<leader>gd", gs.diffthis, "Diff del archivo")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gf", "<cmd>Telescope git_bcommits<CR>", desc = "Commits de este archivo" },
      { "<leader>gn", "<cmd>Telescope git_branches<CR>", desc = "Ramas" },
    },
  },
}
