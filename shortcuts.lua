-- Tconfig
tconfig = "~/.config/nvim/lua/--T/"
vim.api.nvim_create_user_command("Tconfig", "Explore " .. tconfig, { desc = "Explores the nvim/lua/--T directory" })
vim.cmd("cnoreabbrev <expr> tconfig getcmdtype() == ':' && getcmdline() ==# 'tconfig' ? 'Tconfig' : 'tconfig'")

-- Pythondir
pythondir = "~/Desktop/Coding/Python/"
vim.api.nvim_create_user_command("Pythondir", "Explore " .. pythondir, { desc = "Explores the Coding/Python directory" })
vim.cmd("cnoreabbrev <expr> pythondir getcmdtype() == ':' && getcmdline() ==# 'pythondir' ? 'Pythondir' : 'pythondir'")

-- Cdir
cdir = "~/Desktop/Coding/C/"
vim.api.nvim_create_user_command("Cdir", "Explore " .. cdir, { desc = "Explores the Coding/C directory" })
vim.cmd("cnoreabbrev <expr> cdir getcmdtype() == ':' && getcmdline() ==# 'cdir' ? 'Cdir' : 'cdir'")
