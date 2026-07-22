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
