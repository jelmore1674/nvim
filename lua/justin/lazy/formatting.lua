return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

    conform.setup({
      formatters_by_ft = {
        javascript = { { 'dprint', 'prettier' } },
        typescript = { { 'dprint', 'prettier' } },
        javascriptreact = { { 'dprint', 'prettier' } },
        typescriptreact = { { 'dprint', 'prettier' } },
        svelte = { { 'dprint', 'prettier' } },
        astro = { 'biome', 'dprint' },
        css = { { 'dprint', 'prettier' } },
        html = { { 'dprint', 'prettier' } },
        json = { 'dprint', 'prettier' },
        yaml = { 'dprint', 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'dprint', 'prettier' },
        lua = { 'stylua' },
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
        -- prettier = {
        --   args = {
        --     '--config-precedence=prefer-file',
        --     '--single-quote',
        --     '--trailing-comma none',
        --     '--vue-indent-script-and-style',
        --     '--write',
        --     '$FILENAME',
        --   },
        -- },
        shfmt = {
          prepend_args = { '-i', '2' },
          -- The base args are { "-filename", "$FILENAME" } so the final args will be
          -- { "-i", "2", "-filename", "$FILENAME" }
        },

        dprint = {
          condition = function(ctx)
            ---@diagnostic disable-next-line: return-type-mismatch, undefined-field
            return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
      log_level = vim.log.levels.DEBUG,
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
