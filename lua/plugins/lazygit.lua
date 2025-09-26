return {
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit (directorio actual)" },
      { "<leader>gG", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit en root del proyecto" },
    },
    config = function()
      -- Forzar que use plenary para detectar el root del proyecto
      vim.g.lazygit_floating_window_use_plenary = 1
    end,
  },
}
