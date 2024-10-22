return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Surrounding Tags
  'tpope/vim-surround',

  -- cspell
  'davidmh/cspell.nvim',

  'SaschaMendel/vim-quicktype',

  -- deoplete
  'Shougo/deoplete.nvim',

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
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
      require('nvim-autopairs').setup({})
    end,
  },
}
