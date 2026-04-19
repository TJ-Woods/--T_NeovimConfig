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
vim.o.timeoutlen = 100

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
vim.o.scrolloff = 15

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

-- Undotree config
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SplitWidth = 30

-- Enable yank highlighting for clarity
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})
