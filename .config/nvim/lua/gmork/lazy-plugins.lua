-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Core dependencies
  { "nvim-lua/plenary.nvim" },
  
  -- UI and navigation
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
  },
  
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },
  
  { "moll/vim-bbye", cmd = { "Bdelete", "Bwipeout" } },
  
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "folke/tokyonight.nvim",
    },
    event = "UIEnter",
    config = function()
      -- Ensure colorscheme is loaded first
      pcall(vim.cmd, "colorscheme gmork")
    end,
  },
  
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = { "<leader>t" },
  },
  
  { "ahmedkhalf/project.nvim", event = "VeryLazy" },
  -- Note: impatient.nvim is not needed with Lazy.nvim as it has built-in caching
  -- { "lewis6991/impatient.nvim", event = "VeryLazy" },
  { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" } },
  
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  
  -- Session management
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      log_level = "error",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
    },
  },

  -- Sidekick for Claude Code integration
  -- {
  --   "folke/sidekick.nvim",
  --   lazy = false,
  --   config = function()
  --     require("sidekick").setup({
  --       cli = {
  --         size = 80,
  --         position = "right",
  --       },
  --     })
  --     -- Auto-open Claude Code on startup
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       pattern = "*",
  --       callback = function()
  --         vim.defer_fn(function()
  --           -- Only open if we have at least one real buffer
  --           local bufs = vim.fn.getbufinfo({buflisted = 1})
  --           if #bufs > 0 then
  --             require("sidekick.cli").toggle({ name = "claude", focus = false })
  --           end
  --         end, 200)
  --       end,
  --     })
  --   end,
  --   keys = {
  --     { "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude" }) end, desc = "Toggle Claude Code" },
  --     { "<leader>ax", function() require("sidekick.cli").close() end, desc = "Close Sidekick" },
  --   },
  -- },

  -- Vim-obsession for tmux-resurrect integration
  {
    "tpope/vim-obsession",
    lazy = false,
    config = function()
      -- Auto-start tracking sessions when vim opens
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          -- Only start if not already tracking and not in a git directory
          if vim.fn.exists(":Obsession") == 2 and vim.v.this_session == "" then
            local cwd = vim.fn.getcwd()
            if not cwd:match("^/tmp") and not cwd:match("^/private/tmp") then
              vim.cmd("silent! Obsession")
            end
          end
        end,
      })
    end,
  },
  
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "mdx" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  
  -- Colorschemes
  { 
    "folke/tokyonight.nvim", 
    lazy = false,
    priority = 1000,
  },
  { 
    "lunarvim/darkplus.nvim", 
    lazy = false,
    priority = 1000,
  },
  { 
    "Mofiqul/dracula.nvim", 
    lazy = false,
    priority = 1000,
  },
  
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
  
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
  
  { "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },
  { "MunifTanjim/prettier.nvim", ft = { "javascript", "typescript", "json", "css", "html" } },
  
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>f", desc = "Find Files" },
      { "<leader>g", desc = "Live Grep" },
      { "<leader>b", desc = "Buffers" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
  },
  
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "WorktreeList", "WorktreeCreate", "WorktreeSwitch" },
  },
  
  -- Editing enhancements
  { "windwp/nvim-autopairs", event = "InsertEnter" },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
  
  -- Utilities
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  
  -- AI Integration
  {
    "nomnivore/ollama.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    keys = {
      { "<leader>oo", mode = { "n", "v" }, desc = "Ollama prompt" },
      { "<leader>oG", mode = { "n", "v" }, desc = "Ollama Generate Code" },
    },
    opts = {},
    config = function(_, opts)
      require("ollama").setup(opts)
      
      -- Key mappings
      vim.keymap.set({ "n", "v" }, "<leader>oo", function()
        require("ollama").prompt()
      end, { desc = "Ollama prompt" })
      
      vim.keymap.set({ "n", "v" }, "<leader>oG", function()
        require("ollama").prompt("Generate_Code")
      end, { desc = "Ollama Generate Code" })
    end,
  },
  
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "ravenxrz/DAPInstall.nvim",
    },
    keys = {
      { "<leader>d", desc = "Debug" },
    },
  },
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})