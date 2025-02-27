return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    ---@param bufnr integer
    ---@param ... string
    ---@return string
    local function first(bufnr, ...)
      for i = 1, select('#', ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return select(1, ...)
    end

    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

    conform.setup({
      formatters_by_ft = {
        javascript = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        typescript = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        javascriptreact = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        typescriptreact = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        astro = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        svelte = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        css = function(bufnr)
          return { first(bufnr, 'dprint', 'prettier') }
        end,
        html = { 'prettier' },
        json = function(bufnr)
          return { first(bufnr, 'dprint', 'biome') }
        end,
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'dprint', 'prettier' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        cs = { 'csharpier' },
        toml = { 'taplo' },
        caddy = { 'caddy' },
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
        caddy = {
          command = 'caddy',
          args = { 'fmt', '$FILENAME' },
          stdin = true,
        },
        prettier = {
          prepend_args = function(_, ctx)
            if string.match(ctx.filename, 'yaml') or string.match(ctx.filename, 'yml') then
              return {}
            else
              return { '--single-quote', '--conifg-precedence', 'file-override' }
            end
          end,
        },
        shfmt = {
          prepend_args = { '-i', '2' },
          -- The base args are { "-filename", "$FILENAME" } so the final args will be
          -- { "-i", "2", "-filename", "$FILENAME" }
        },

        yamlfix = {
          -- Adds environment args to the yamlfix formatter
          env = {
            YAMLFIX_SEQUENCE_STYLE = 'block_style',
          },
        },

        dprint = {
          condition = function(ctx)
            ---@diagnostic disable-next-line: return-type-mismatch, undefined-field
            return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
          end,
        },

        -- stylelint = {
        --   condition = function(ctx)
        --     ---@diagnostic disable-next-line: return-type-mismatch, undefined-field
        --     return vim.fs.find({ '.stylelintrc.mjs' }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
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
