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

    vim.keymap.set('n', '<leader>f', conform.format, { desc = '[F]ormat' })

    conform.setup {
      formatters_by_ft = {
        javascript = { 'dprint', 'prettier' },
        typescript = { 'dprint', 'prettier' },
        javascriptreact = { 'dprint', 'prettier' },
        typescriptreact = { 'dprint', 'prettier' },
        svelte = { 'dprint', 'prettier' },
        astro = { 'dprint', 'prettierd' },
        css = { 'dprint', 'prettier' },
        html = { 'dprint', 'prettier' },
        json = { 'dprint', 'prettier' },
        yaml = { 'dprint', 'prettier' },
        markdown = { 'dprint', 'prettier' },
        graphql = { 'dprint', 'prettier' },
        liquid = { 'dprint', 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        prettierd = {
          args = {
            '--config-precedence prefer-file',
            '--single-quote',
            '--trailing-comma none',
            '--vue-indent-script-and-style',
            '--write',
            '$FILENAME',
            '--plugin=prettier-plugin-astro',
          },
        },

        dprint = {
          condition = function(ctx)
            return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
      log_level = vim.log.levels.DEBUG,
    }

    conform.formatters.shfmt = {
      prepend_args = { '-i', '2' },
      -- The base args are { "-filename", "$FILENAME" } so the final args will be
      -- { "-i", "2", "-filename", "$FILENAME" }
    }

    conform.formatters.prettier = {
      append_args = function(self, ctx) end,
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
