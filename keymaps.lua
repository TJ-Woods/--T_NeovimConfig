-- Set 'kj' to enter Normal mode
vim.keymap.set({ "i", "v" }, "kj", "<Esc>")

-- Create shortcut to save and exit to Explorer
vim.api.nvim_create_user_command("We", "write | Explore", { desc = "Writes and exits to Explorer" })
vim.cmd([[cnoreabbrev <expr> we getcmdtype() == ':' && getcmdline() ==# 'we' ? 'We' : 'we']])

-- Create shortcut to enter Home/Coding/Python in Explorer
local python_dir = "C:/Users/travi/OneDrive/Desktop/Coding/Python"
vim.api.nvim_create_user_command(
	"Pythondir",
	"Explore " .. python_dir,
	{ desc = "Enters the Explorer in the Python directory" }
)
vim.cmd(
	[[cnoreabbrev <expr> pythondir getcmdtype() == ':' && getcmdline() ==# 'pythondir' ? 'Pythondir' : 'pythondir']]
)

-- Create shortcut to enter Home/Coding/Python in Explorer
local TConfig_dir = "C:/Program Files/Neovim/bin/lua/--T/"
vim.api.nvim_create_user_command(
	"TConfig",
	"Explore " .. TConfig_dir,
	{ desc = "Enters the Explorer in the Python directory" }
)
vim.cmd([[cnoreabbrev <expr> tconfig getcmdtype() == ':' && getcmdline() ==# 'tconfig' ? 'TConfig' : 'tconfig']])

-- Clear highlights on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Set <leadre>ut to UndotreeToggle
vim.keymap.set("n", "<leader>ut", "<cmd>:UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- Set <C-\\> to start of written line
vim.keymap.set("n", "<C-\\>", "^", { desc = "GOTO start of written line" })

-- <A-r> run file in terminal
vim.keymap.set("n", "<A-r>", Run_curr_file, { desc = "Run the current file in the terminal" })

-- neogit auto cwd=%
vim.cmd([[noreabbrev <expr> ngit getcmdtype() == ':' && getcmdline() ==# 'ngit' ? 'Neogit cwd=%' : 'ngit']])
