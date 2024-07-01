return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',

  -- comment box
  {
    'LudoPinelli/comment-box.nvim',
    config = function()
      require('comment-box').setup {}
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Titles
      opts.desc = '[C]omment [B]ox'
      keymap({ 'n', 'v' }, '<Leader>cb', '<Cmd>CBccbox<CR>', opts)
      -- Named parts
      opts.desc = '[C]omment [L]ine'
      keymap({ 'n', 'v' }, '<Leader>cl', '<Cmd>CBlcline<CR>', opts)
      -- Simple line
      -- keymap('n', '<Leader>cl', '<Cmd>CBline<CR>', opts)
      -- keymap("i", "<M-l>", "<Cmd>CBline<CR>", opts) -- To use in Insert Mode
      -- Marked comments
      -- keymap({ 'n', 'v' }, '<Leader>cm', '<Cmd>CBllbox14<CR>', opts)
      -- Removing a box is simple enough with the command (CBd), but if you
      -- use it a lot:
      opts.desc = '[C]omment [D]elete'
      keymap({ 'n', 'v' }, '<Leader>cd', '<Cmd>CBd<CR>', opts)
    end,
  },
}
