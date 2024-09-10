return {
  'rebelot/kanagawa.nvim',
  config = function()
    require('kanagawa').setup({
      theme = 'dragon',
    })
    vim.cmd('colorscheme kanagawa')
  end
}
