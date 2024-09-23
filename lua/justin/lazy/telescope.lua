return {
  'nvim-telescope/telescope.nvim',

  tag = '0.1.5',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'someone-stole-my-name/yaml-companion.nvim',
  },

  config = function()
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- Enable telescope worktree extension, if installed
    require('telescope').load_extension('git_worktree')
    require('telescope').load_extension('yaml_schema')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set(
      'n',
      '<leader>gwl',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      { desc = 'Search [G]it [W]orktree [L]ist' }
    )
    vim.keymap.set(
      'n',
      '<leader>gwc',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      { desc = 'Search [G]it [W]orktree [C]reate' }
    )

    vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = '[G]it [B]ranches' })
  end,
}
