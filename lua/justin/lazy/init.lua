return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Surrounding Tags
  'tpope/vim-surround',

  -- cspell
  'davidmh/cspell.nvim',

  'SaschaMendel/vim-quicktype',

  -- vim-wiki
  'vimwiki/vimwiki',

  -- deoplete
  'Shougo/deoplete.nvim',

  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  -- Todo Comments for pretty Comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
}
