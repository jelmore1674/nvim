local prettier = require("prettier")

local file_types = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "md",
    "mdx-analyzer",
    "scss",
    "typescript",
    "typescriptreact",
}

prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
    filetypes = file_types,
    cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        jsx_bracket_same_line = false,
        jsx_single_quote = false,
        print_width = 80,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = false,
        tab_width = 2,
        trailing_comma = "none",
        use_tabs = false,
        vue_indent_script_and_style = true,
    },
})

vim.keymap.set("n", "<leader>pp", ":Prettier<cr>")

return {
    -- css formating lsp servers
    cssls = "",
    cssmodules_ls = "",
    -- graphql lsp
    graphql = "",
    -- html lsp
    html = "",
    -- json lsp
    jsonls = "",
    -- markdown lsp
    marksman = "",
    -- js/ts lsp
    eslint = "tsserver",
    tsserver = "eslint",
    -- yaml lsp
    --    yamlls = "yamlls"
};
