local function prettier_or_dprint(bufnr)
  if require('conform').get_formatter_info('dprint', bufnr).available then
    return { 'dprint' }
  else
    return { 'prettier' }
  end
end

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      javascript = { 'dprint', { 'prettierd', 'prettier' } },
      typescript = { 'dprint', { 'prettierd', 'prettier' } },
      javascriptreact = { 'dprint', { 'prettierd', 'prettier' } },
      typescriptreact = { 'dprint', { 'prettierd', 'prettier' } },
      svelte = { { 'dprint', 'prettier' } },
      css = { { 'dprint', 'prettier' } },
      html = { { 'dprint', 'prettier' } },
      json = { { 'dprint', 'prettier' } },
      yaml = { { 'dprint', 'prettier' } },
      markdown = { { 'dprint', 'prettier' } },
      graphql = { { 'dprint', 'prettier' } },
      liquid = { { 'dprint', 'prettier' } },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        dprint = {
          condition = function(ctx)
            print(ctx.filename)
            return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
