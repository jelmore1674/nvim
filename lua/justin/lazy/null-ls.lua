return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = {
        null_ls.builtins.completion.spell,
        require 'none-ls.diagnostics.eslint',  -- requires none-ls-extras.nvim
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.textlint,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.zsh,
        -- null_ls.builtins.formatting.biome,
        -- null_ls.builtins.formatting.markdownlint,
        -- null_ls.builtins.formatting.pg_format,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prisma_format,
        -- null_ls.builtins.formatting.shfmt,
        -- null_ls.builtins.formatting.stylelint,
        -- null_ls.builtins.formatting.stylua,
      },
      -- on_attach = function(client, bufnr)
      --   if client.supports_method 'textDocument/formatting' then
      --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      --         -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
      --         vim.lsp.buf.format { async = false }
      --       end,
      --     })
      --   end
      -- end,
    }
  end,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
}
