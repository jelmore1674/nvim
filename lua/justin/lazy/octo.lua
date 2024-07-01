local keymap = function(key, cmd, desc)
  vim.keymap.set('n', key, cmd, { noremap = true, silent = true, desc = desc })
end

return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- OR 'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup({ enable_builtin = true, suppress_missing_scope = {
      projects_v2 = true,
    } })
    -- TODO: Configure Keybinds
    keymap('<leader>opl', '<Cmd>Octo pr list<CR>', '[O]cto [P]ull Request [L]ist ')
  end,
}
