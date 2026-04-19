
-- 'kj' for exit
vim.keymap.set( { "i", "v" }, "kj", "<Esc>" )

-- 'vse' to vsplit and explore
vim.api.nvim_create_user_command( "Vse", "vsplit | Explore",  { desc = "Vsplits and exits to explorer" } )
vim.cmd("cnoreabbrev <expr> vse getcmdtype() == ':' && getcmdline() ==# 'vse' ? 'Vse' : 'vse'")

-- 'we' to save and explore
vim.api.nvim_create_user_command( "We", "write | Explore", { desc = "Writes and exits to explorer" } )
vim.cmd("cnoreabbrev <expr> we getcmdtype() == ':' && getcmdline() ==# 'we' ? 'We' : 'we'")

-- '<C-#>' to move between splits (#= hjkl)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move cursor to window left" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move cursor to window down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move cursor to window up" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move cursor to window right" })

-- '<esc>' to escape hl
vim.keymap.set("n", "<Esc>", "<Cmd>nohl<Cr>", { desc = "Escape hl" })

-- '<A-#>' to move selected (#= hjkl)
vim.keymap.set("n", "<A-j>", ":m .+1<Cr>==", { desc = "Move current line down"})
vim.keymap.set("n", "<A-k>", ":m .-2<Cr>==", { desc = "Move current line up"})
vim.keymap.set("v", "<A-j>", ":m '>+1<Cr>gv=gv", { desc = "Move selected down"})
vim.keymap.set("v", "<A-k>", ":m '<-2<Cr>gv=gv", { desc = "Move selected up"})

-- splt / vsplt to open terminal in split or vsplit window
vim.api.nvim_create_user_command( "Splt", "split | terminal", { desc = "splits and opens terminal" })
vim.api.nvim_create_user_command( "Vsplt", "vsplit | terminal", { desc = "vsplits and opens terminal" })
vim.cmd("cnoreabbrev <expr> splt getcmdtype() == ':' && getcmdline() ==# 'splt' ? 'Splt' : 'splt'")
vim.cmd("cnoreabbrev <expr> vsplt getcmdtype() == ':' && getcmdline() ==# 'vsplt' ? 'Vsplt' : 'vsplt'")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to system cliyboard" })

-- Undotree toggle
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

-- ngit auto open Neogit cwd=%
vim.api.nvim_create_user_command("Ngit", "Neogit cwd=%", { desc = "Opens Neogit with the current working directory" })
vim.cmd("cnoreabbrev <expr> ngit getcmdtype() == ':' && getcmdline() ==# 'ngit' ? 'Ngit' : 'ngit'")
