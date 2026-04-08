
-- 'kj' for exit
vim.keymap.set( { "i", "v" }, "kj", "<Esc>" )

-- 'vse' to vsplit and explore
vim.api.nvim_create_user_command( "Vse", "vsplit | Explore",  { desc = "Vsplits and exits to explorer" } )
vim.cmd("cnoreabbrev <expr> vse getcmdtype() == ':' && getcmdline() ==# 'vse' ? 'Vse' : 'vse'")

-- 'we' to save and explore
vim.api.nvim_create_user_command( "We", "write | Explore", { desc = "Writes and exits to explorer" } )
vim.cmd("cnoreabbrev <expr> we getcmdtype() == ':' && getcmdline() ==# 'we' ? 'We' : 'we'")
