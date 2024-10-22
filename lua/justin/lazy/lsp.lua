return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Completion
    'hrsh7th/nvim-cmp',
    'j-hui/fidget.nvim',

    -- -- Go
    -- 'ray-x/go.nvim',
    -- 'ray-x/guihua.lua', -- recommended if need floating window support

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'b0o/schemastore.nvim',
  },

  config = function()
    -- Setup neovim lua configuration
    require('neodev').setup()
    require('fidget').setup({})

    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.

      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>cA', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')
    end

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    local cmp_lsp = require('cmp_nvim_lsp')
    local capabilities =
      vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    local servers = {
      -- Web
      -- javascript/typescript
      --biome = {},
      ts_ls = {},
      astro = {
        provideFormatter = false,
      },

      dprint = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
          'jsonc',
          'markdown',
          'python',
          'toml',
          'rust',
          'roslyn',
          'astro',
        },
      },

      html = {
        provideFormatter = false,
      },
      emmet_language_server = {},

      -- css
      cssls = {},
      cssmodules_ls = {},
      -- stylelint_lsp = {
      --   stylelintplus = {
      --     -- see available options in stylelint-lsp documentation
      --     autoFixOnSave = true,
      --     autoFixOnFormat = true,
      --   },
      -- },

      -- Graphql
      graphql = {
        root_dir = function()
          return vim.loop.cwd()
        end,
      },

      -- Dotnet
      -- csharp_ls = {},
      -- omnisharp = {}

      -- Docker
      dockerls = {},
      docker_compose_language_service = {},

      -- Android
      gradle_ls = {},
      -- java_language_server = {},
      kotlin_language_server = {},

      -- YAML
      azure_pipelines_ls = {},
      yamlls = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = '',
          },
          -- schemas = require('schemastore').yaml.schemas(),
          -- schemas = {
          --   ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
          --   ['https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/assets/javascripts/editor/schema/ci.json'] = '/gitlab-ci.yml',
          --   ['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook'] = '**/playbooks/*.yml',
          -- },
          -- schemaDownload = { enable = true },
          -- validate = true,
        },
      },
      gitlab_ci_ls = {},

      -- Markdown
      marksman = {},

      -- nginx
      nginx_language_server = {},

      -- SQL
      -- postgres_lsp = {},
      sqlls = {},

      -- rust
      rust_analyzer = {},

      -- go
      gopls = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },

      -- lua
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },

      -- bash
      bashls = {},
    }

    -- Mason
    require('mason').setup({})

    -- Ensure the servers above are installed
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
    local cfg = require('yaml-companion').setup({
      -- Add any options here, or leave empty to use the default settings
      lspconfig = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = '',
          },
          schemas = require('schemastore').yaml.schemas(),
          -- schemas = {
          --   ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
          --   ['https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/assets/javascripts/editor/schema/ci.json'] = '/gitlab-ci.yml',
          -- },
          -- schemaDownload = { enable = true },
          -- validate = true,
        },
      },
    })
    require('lspconfig')['yamlls'].setup(cfg)

    vim.keymap.set('n', '<leader>yc', ':Telescope yaml_schema<CR>')

    require('lspconfig').csharp_ls.setup({})

    require('lspconfig').stylelint_lsp.setup({
      filetypes = { 'css', 'scss' },
      root_dir = require('lspconfig').util.root_pattern('package.json', '.git'),
      settings = {
        stylelintplus = {
          -- see available options in stylelint-lsp documentation
          -- autoFixOnFormat = true,
          -- autoFixOnSave = true,
        },
      },
      on_attach = function(client)
        client.server_capabilities.document_formatting = false
      end,
    })

    local isLspDiagnosticsVisible = true
    vim.keymap.set('n', '<leader>lx', function()
      isLspDiagnosticsVisible = not isLspDiagnosticsVisible
      vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible,
      })
    end)
  end,
}
