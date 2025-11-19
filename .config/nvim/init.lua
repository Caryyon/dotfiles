vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set up lazy.nvim and plugins first
require("gmork.lazy-plugins")

-- Core configuration
require("gmork.options")
require("gmork.keymaps")
require("gmork.autocommands")
require("gmork.colorscheme")
require("gmork.commands")
require("gmork.cmp")
require("gmork.snippets")
require("gmork.telescope")
require("gmork.gitsigns")
require("gmork.git-worktree")
require("gmork.treesitter")
require("gmork.mdx")
require("gmork.mdx-preview")
require("gmork.autopairs")
require("gmork.comment")
require("gmork.nvim-tree")
require("gmork.bufferline")
require("gmork.lualine")
require("gmork.toggleterm")
-- impatient.nvim not needed with Lazy.nvim
-- require("gmork.impatient")
require("gmork.illuminate")
require("gmork.indentline")
require("gmork.alpha")
require("gmork.smart-project")
require("gmork.lsp")
require("gmork.dap")
require("gmork.vim-tidal")
