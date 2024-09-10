local builtin = require('telescope.builtin')

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ff', builtin.find_files, desc = 'Find files' },
    { '<leader>fg', builtin.live_grep, desc = 'Grep' },
    { '<leader>fb', builtin.buffers, desc = 'Buffers' },
    { '<leader>fh', builtin.help_tags, desc = 'Search help' },
    { '<C-p>',      builtin.git_files, desc = 'Git files' },
  },
}
