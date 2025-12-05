local servers = {
	"lua_ls",
	"vtsls",
	"cssls",
	"html",
	"pyright",
	-- "bashls", -- Commented out due to installation issues
	"jsonls",
	"yamlls",
	"rust_analyzer",
	"tailwindcss",
	-- "denols", -- Disabled to avoid conflicts with ts_ls
	"svelte",
	"mdx_analyzer",
	"clangd",
	"eslint",
	"graphql",
	"marksman",
	"remark_ls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig = require("lspconfig")

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("gmork.lsp.handlers").on_attach,
		capabilities = require("gmork.lsp.handlers").capabilities,
	}

	local require_ok, conf_opts = pcall(require, "gmork.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

