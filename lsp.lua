require("mason").setup()
local cmp = require("cmp")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("glslls")
vim.lsp.enable("glsl_analyzer")
vim.lsp.enable("zls")
-- vim.lsp.enable("asm_lsp")
vim.lsp.enable("html_lsp")
vim.lsp.enable("css_lsp")
vim.lsp.enable("emmet_ls")

vim.lsp.config("clangd", {
    capabilities = capabilities,
})
vim.lsp.config("pyright", {
    capabilities = capabilities,
})
vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
})
vim.lsp.config("glsl_analyzer", {
    capabilities = capabilities,
})
vim.lsp.config("glslls", {
    capabilities = capabilities,
})
vim.lsp.config("zls", {
    capabilities = capabilities,
})
-- vim.lsp.config("asm_lsp", {
--     capabilities = capabilities,
-- })
vim.lsp.config("html_lsp", {
    capabilities = capabilities,
})
vim.lsp.config("css_lsp", {
    capabilities = capabilities,
})
vim.lsp.config("emmet_ls", {
    capabilities = capabilities,
})

cmp.setup ({
--    completion = {
--        autocomplete = false;
--    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    }),
    sources = cmp.config.sources({
        {name = "nvim_lsp"}
    })
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "⦿",
    spacing = 2,
  },
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})
