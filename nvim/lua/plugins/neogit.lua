return {
  'NeogitOrg/neogit',
  config = function()
    require('neogit').setup {
      integrations = {
        diffview = true,
      },
    }
    vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { desc = 'Neogit' })
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
}
