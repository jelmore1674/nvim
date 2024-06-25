-- import sets
-- require 'custom.set'

--- import remaps
require 'custom.remap'



-- [[ Basic Keymaps ]]

-- -- [[ Configure Treesitter ]]
-- -- See `:help nvim-treesitter`
-- require('nvim-treesitter.configs').setup {
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = { 'bash', 'dockerfile', 'css', 'diff', 'gitignore', 'html', 'jsdoc', 'javascript', 'lua', 'scss',
--     'rust', 'sql', 'toml', 'tsx', 'typescript', 'yaml', 'markdown',
--     'vimdoc', 'vim' },
--
--   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--   auto_install = true,
--
--
--   autotag = {
--     enable = true,
--     enable_rename = true,
--     enable_close = true,
--     enable_close_on_slash = true,
--   },
--
--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<M-space>',
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['aa'] = '@parameter.outer',
--         ['ia'] = '@parameter.inner',
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner',
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']m'] = '@function.outer',
--         [']]'] = '@class.outer',
--       },
--       goto_next_end = {
--         [']M'] = '@function.outer',
--         [']['] = '@class.outer',
--       },
--       goto_previous_start = {
--         ['[m'] = '@function.outer',
--         ['[['] = '@class.outer',
--       },
--       goto_previous_end = {
--         ['[M'] = '@function.outer',
--         ['[]'] = '@class.outer',
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leader>.'] = '@parameter.inner',
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner',
--       },
--     },
--   },
-- }
-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- -- parser_config.hypr = {
-- --   install_info = {
-- --     url = "https://github.com/luckasRanarison/tree-sitter-hypr",
-- --     files = { "src/parser.c" },
-- --     branch = "master",
-- --   },
-- --   filetype = "hypr",
-- -- }
--
-- parser_config.bash.filetype_to_parsername = "_"
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- -- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>cA', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- -- Enable the following language servers
-- --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- --  Add any additional override configuration in the following tables. They will be passed to
-- --  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = {
--   rust_analyzer = {},
--   tsserver = {
--     capabilities = capabilities
--   },
--   gopls = {},
--   -- biome = {
--   --   capabilities = capabilities
--   -- },
--   eslint = {
--     capabilities = capabilities
--   },
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
--   html = {
--     provideFormatter = false
--   },
--   cssls = {},
--   bashls = {},
--   graphql = {
--     capabilities = capabilities,
--     root_dir = function() return vim.loop.cwd() end
--   },
--   jsonls = {},
--   marksman = {},
--   prismals = {},
--   sqlls = {},
--   taplo = {},
--   omnisharp = {
--
--   },
--   kotlin_language_server = {},
--   stylelint_lsp = {
--     stylelintplus = {
--       -- see available options in stylelint-lsp documentation
--       -- autoFixOnSave = true,
--       -- autoFixOnFormat = true
--     },
--   },
-- }
--
-- -- Setup neovim lua configuration
-- require('neodev').setup()
--
-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     if server_name == 'omnisharp' then
--       require 'lspconfig'.omnisharp.setup {
--         --     cmd = { "dotnet", "~/.local/share/nvim/mason/bin/omnisharp" },
--
--         -- Enables support for roslyn analyzers, code fixes and rulesets.
--         enable_roslyn_analyzers = true,
--
--         -- Specifies whether 'using' directives should be grouped and sorted during
--         -- document formatting.
--         organize_imports_on_format = true,
--
--         -- Enables support for showing unimported types and unimported extension
--         -- methods in completion lists. When committed, the appropriate using
--         -- directive will be added at the top of the current file. This option can
--         -- have a negative impact on initial completion responsiveness,
--         -- particularly for the first few completion sessions after opening a
--         -- solution.
--         enable_import_completion = true,
--       }
--     else
--       require('lspconfig')[server_name].setup {
--         capabilities = capabilities,
--         on_attach = on_attach,
--         settings = servers[server_name],
--       }
--     end
--   end,
-- }
--
-- require 'lspconfig'.biome.setup {}
--

-- local highlight = {
--   "RainbowRed",
--   "RainbowYellow",
--   "RainbowBlue",
--   "RainbowOrange",
--   "RainbowGreen",
--   "RainbowViolet",
--   "RainbowCyan",
-- }
--
-- local hooks = require "ibl.hooks"
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
-- end)
--
-- require("ibl").setup {
--   indent = { highlight = highlight },
--   whitespace = {
--     highlight = highlight,
--   },
--   scope = { enabled = true },
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
-- require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}
--
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-j>'] = cmp.mapping.select_next_item(),
--     ['<C-k>'] = cmp.mapping.select_prev_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-u>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete({}),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     }),
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   }),
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--     { name = 'async_path' },
--     {
--       name = 'spell',
--       option = {
--         keep_all_entries = false,
--         enable_in_context = function()
--           return require('cmp.config.context').in_treesitter_capture('spell')
--         end,
--       },
--     },
--   },
-- }

-- vim.cmd [[
-- hi Normal ctermbg=NONE
-- hi NonText ctermbg=NONE
-- hi Normal guibg=NONE
-- ]]
--

-- require 'colorizer'.setup {
--   '*',                      -- Highlight all files, but customize some others.
--   css = { rgb_fn = true, }, -- Enable parsing rgb(...) functions in css.
-- }

-- require("hooks.worktree")
-- require("custom")
require 'justin'
