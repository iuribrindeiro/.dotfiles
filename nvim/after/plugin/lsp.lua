local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver' },
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<S-Tab>'] = nil
    })
})


local lspconfig = require('lspconfig')

lspconfig.omnisharp.setup({
    enable_roslyn_analysers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
    filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx' },
})

lsp_zero.set_preferences({
    suggest_lsp_servers = true,
})

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    lsp_zero.buffer_autoformat()
end)

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = true
})
