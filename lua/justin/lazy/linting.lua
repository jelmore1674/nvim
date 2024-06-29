local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    return true
  end
  return false
end

return {}

-- return {
--   'mfussenegger/nvim-lint',
--   event = { 'BufReadPre', 'BufNewFile' },
--   config = function()
--     local lint = require 'lint'
--
--     lint.linters_by_ft = {
--       javascript = { 'eslint_d' },
--       typescript = { 'eslint_d' },
--       javascriptreact = { 'eslint_d' },
--       typescriptreact = { 'biomejs', 'eslint_d' },
--       svelte = { 'eslint_d' },
--       python = { 'pylint' },
--       sh = { 'shellcheck' },
--       -- Use the "*" filetype to run linters on all filetypes.
--       ['*'] = { 'cspell', 'codespell' },
--     }
--
--     local cur_dir = vim.fn.getcwd()
--     if file_exists(cur_dir .. '/biome.json') then
--       lint.linters_by_ft = {
--         javascript = { 'biomejs' },
--         javascriptreact = { 'biomejs' },
--         typescriptreact = { 'eslint' },
--         svelte = { 'eslint_d' },
--         python = { 'pylint' },
--       }
--     end
--
--     local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = false })
--
--     vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
--       group = lint_augroup,
--       callback = function()
--         lint.try_lint()
--       end,
--     })
--
--     vim.keymap.set('n', '<leader>lf', function()
--       lint.try_lint()
--     end, { desc = 'Trigger linting for current file' })
--   end,
-- }
