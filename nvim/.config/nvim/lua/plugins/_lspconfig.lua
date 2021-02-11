local nvim_lsp = require("lspconfig")

local function on_attach(client, bufnr)
  print("LSP started.")

  -- For built-in LSP omnifunc:
  -- vim.api.nvim_buf_set_option(bufnr, "completefunc", "v:lua.vim.lsp.omnifunc")
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- For completion-nvim:
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "")
  require("completion").on_attach(client)

  require("mappings.nvim_lsp").load()
end

local status, _ = pcall(require, "_lspconfig_py")
local py_lsp = status and nvim_lsp.py_custom or nvim_lsp.pyright
py_lsp.setup { on_attach = on_attach }

local status, _ = pcall(require, "_lspconfig_matlab")
if status then
  nvim_lsp.matlab.setup { on_attach = on_attach }
end

local servers = {
  "bashls",
  "ccls",
  "clojure_lsp",
  "cmake",
  "cssls",
  "hls",
  "html",
  "jdtls",
  "jsonls",
  "kotlin_language_server",
  "metals",
  -- "pyright",
  "rust_analyzer",
  -- "sumneko_lua",
  "texlab",
  "tsserver",
  "vimls",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- vim.cmd "autocmd BufEnter * lua require('completion').on_attach()"