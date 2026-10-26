-- Line Numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Enable Mouse
vim.o.mouse = "a"

-- Enable broken indent for line wrapping
vim.o.breakindent = true

-- Enable undo file saving
vim.o.undofile = true

-- Case insensitivity for searches unless specified
vim.o.ignorecase = true
vim.o.smartcase = true

-- Signcolumn always visible
vim.o.signcolumn = "yes"

-- Decrease update time (ms)
vim.o.updatetime = 250

-- Decrease mapped sequence wait time (ms)
vim.o.timeoutlen = 200

-- Set splitting directions
vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show typing suggestions as you type
vim.o.inccommand = "split"

-- Highlight cursor line
vim.o.cursorline = true

-- Set minimum line above/below for scrolling
vim.o.scrolloff = 20

-- Enable ask-to-confirm when needed
vim.o.confirm = true

-- Expand tabs to spaces
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

-- Enable treesitter upon file open
vim.api.nvim_create_autocmd("Filetype", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Enable true colour
vim.opt.termguicolors = true

-- Enable yank highlighting for clarity
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Disable showing mode (mini statusline does this instead)
vim.o.showmode = false

-- Folding
vim.o.foldenable = true
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 8
vim.o.foldtext = ""
vim.o.foldlevelstart = 99
vim.o.foldcolumn="4"
vim.opt.fillchars = {
  fold = " ",
  foldopen = "󰅀",
  foldclose = "󰅂",
  foldinner = " ",
  foldsep = " ",
}

-- Add border to popup windows
vim.o.winborder = "rounded"

-- Block Netrw in favour of Neotree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Autocompletion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Syntax highlighting
local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
  ts_configs.setup({
    ensure_installed = { "c", "cpp", "python", "nix", "lua", "vim", "vimdoc" },
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  })
end

-- LSP config
-- Global LspAttach autocmd for keymaps and built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Enable Neovim's built-in completion
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- LSP Buffer Keymaps
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Configure servers directly via vim.lsp.config table
-- (Default configurations like filetypes and root markers are inherited from nvim-lspconfig)

-- C / C++ (clangd)
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
  },
}

-- Python (pyright)
vim.lsp.config.pyright = {}

-- Nix (nil)
vim.lsp.config.nil_ls = {}

-- Enable the configured servers
vim.lsp.enable({ "clangd", "pyright", "nil_ls" })

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = {
    prefix = "-",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
