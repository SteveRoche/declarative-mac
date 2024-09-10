return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>f', group = 'telescope' },
    },
  },
  keys = {
    { '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer local keymaps (which-key)',
    },
  },
}
