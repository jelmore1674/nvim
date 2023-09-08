-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior
--
local function escape_path(arg)
  return vim.fn.shellescape(arg, true)
end

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    return true
  end
  return false
end

-- if the client is compatible with prettier
local is_prettier_formatting = function(client_id)
  local file_types = require("custom.prettier")
  -- format files in prettier config with prettier
  for _, prettier_client in ipairs(file_types) do
    if client_id == prettier_client then
      return true
    end
    return false
  end
end

return {
  "chrisgrieser/nvim-lspconfig",
  -- 'neovim/nvim-lspconfig',
  config = function()
    -- Switch for controlling whether you want autoformatting.
    --  Use :KickstartFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          if not is_prettier_formatting(client.id) then
            return
          end
        end
        --
        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            local prettier = require("prettier")

            local cur_dir = vim.fn.getcwd()
            if file_exists(cur_dir .. '/dprint.json') then
              return
            end

            if client.name == "bashls" then
              vim.cmd("Shfmt")
              return
            end

            -- if format is not enabled, do nothing
            if not format_is_enabled then
              return
            end

            if not is_prettier_formatting(client.name) then
              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
              return
            end

            prettier.format()
          end,
        })

        -- Format dprint after saving the buffer
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            local cur_dir = vim.fn.getcwd()
            if file_exists(cur_dir .. '/dprint.json') then
              vim.cmd("silent !dprint fmt %")
              return
            end
          end
        })
      end,
    })
  end,
}
