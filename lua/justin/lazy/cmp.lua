---@diagnostic disable: unused-local

return {
  'hrsh7th/cmp-nvim-lsp',

  dependencies = {
    'hrsh7th/cmp-buffer', -- source text in current buffer
    'hrsh7th/cmp-path', -- source file system paths
    'FelipeLema/cmp-async-path', -- Adds path auto complete
    'hrsh7th/cmp-calc', -- evaluating mathematical expressions
    'hrsh7th/cmp-emoji', -- emojis
    'hrsh7th/cmp-nvim-lua', -- nvim lua api
    'saadparwaiz1/cmp_luasnip',

    {
      'L3MON4D3/LuaSnip',
      -- Adds a number of user-friendly snippets
      dependencies = { 'rafamadriz/friendly-snippets' },
    },

    { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' }, -- git completion

    -- gitmojis
    {
      'Dynge/gitmoji.nvim',
      dependencies = {
        'hrsh7th/nvim-cmp',
      },
      opts = { -- the values below are the defaults
        filetypes = { 'gitcommit' },
        completion = {
          append_space = false,
          complete_as = 'emoji',
        },
      },
      ft = 'gitcommit',
    },
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'calc' },
        { name = 'buffer' },
        { name = 'async_path' },
        { name = 'nvim_lua' },
        { name = 'emoji' },
        { name = 'git' }, -- git stuffs
        { name = 'gitmoji' }, -- git emojis
      }),
    })

    -- Configure git completions
    local format = require('cmp_git.format')
    local sort = require('cmp_git.sort')

    require('cmp_git').setup({
      -- defaults
      filetypes = { 'gitcommit', 'octo' },
      remotes = { 'upstream', 'origin' }, -- in order of most to least prioritized
      enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
      git = {
        commits = {
          limit = 100,
          sort_by = sort.git.commits,
          format = format.git.commits,
        },
      },
      github = {
        hosts = {}, -- list of private instances of github
        issues = {
          fields = { 'title', 'number', 'body', 'updatedAt', 'state' },
          filter = 'all', -- assigned, created, mentioned, subscribed, all, repos
          limit = 100,
          state = 'open', -- open, closed, all
          sort_by = sort.github.issues,
          format = format.github.issues,
        },
        mentions = {
          limit = 100,
          sort_by = sort.github.mentions,
          format = format.github.mentions,
        },
        pull_requests = {
          fields = { 'title', 'number', 'body', 'updatedAt', 'state' },
          limit = 100,
          state = 'open', -- open, closed, merged, all
          sort_by = sort.github.pull_requests,
          format = format.github.pull_requests,
        },
      },
      trigger_actions = {
        {
          debug_name = 'git_commits',
          trigger_character = ':',
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.git:get_commits(callback, params, trigger_char)
          end,
        },
        {
          debug_name = 'github_issues_and_pr',
          trigger_character = '#',
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = 'github_mentions',
          trigger_character = '@',
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_mentions(callback, git_info, trigger_char)
          end,
        },
      },
    })
  end,
}
