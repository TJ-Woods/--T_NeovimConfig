-- Create user command lowercase bind
local function create_user_command(title, cmd, descr)
  local little_title = title:lower()
  vim.api.nvim_create_user_command(title, cmd, { desc = descr })
  vim.cmd("cnoreabbrev <expr> " .. little_title .. " getcmdtype() == ':' && getcmdline() ==# '" .. little_title .. "' ? '" .. title .. "' : '" .. little_title .. "'")
end

-- 'kj' for exit
vim.keymap.set( { "i", "v" }, "kj", "<Esc>" )

-- escapes for enter normal mode in terminal
vim.keymap.set("t", "kj", "<c-\\><c-n>", { desc = "Enter normal mode in terminal" })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Enter normal mode in terminal" })

-- 'vse' to vsplit and explore
create_user_command("Vse", "vsplit | Explore", "Vsplits and exits to explorer")

-- 'we' to save and explore
create_user_command("We", "write | Explore", "Writes and exits to explorer")

-- '<C-#>' to move between splits (#= hjkl)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move cursor to window left" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move cursor to window down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move cursor to window up" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move cursor to window right" })

-- Remove NETRW <C-l> keymap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { buffer = true })
  end
})

-- '<esc>' to escape hl
vim.keymap.set("n", "<Esc>", "<Cmd>nohl<Cr>", { desc = "Escape hl" })

-- '<A-#>' to move selected (#= hjkl)
vim.keymap.set("n", "<A-j>", ":m .+1<Cr>==", { desc = "Move current line down"})
vim.keymap.set("n", "<A-k>", ":m .-2<Cr>==", { desc = "Move current line up"})
vim.keymap.set("v", "<A-j>", ":m '>+1<Cr>gv=gv", { desc = "Move selected down"})
vim.keymap.set("v", "<A-k>", ":m '<-2<Cr>gv=gv", { desc = "Move selected up"})

-- splt / vsplt to open terminal in split or vsplit window
create_user_command("Splt", "split | terminal", "splits and opens terminal")
create_user_command("Vsplt", "vsplit | terminal", "vsplits and opens terminal")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to system cliyboard" })

-- Undotree toggle
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })

-- ngit auto open Neogit cwd=%
create_user_command("Ngit", "Neogit cwd=%", "Opens Neogit with the current working directory")

-- mini.files open shortcut
vim.keymap.set("n", "<leader>-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Opens the mini.files buffer" })

-- mini.files vsplit open
create_user_command("Vsm", "vsplit | lua MiniFiles.open()", "Opens new vsplit and enters mini.files buffer")

-- '<leader>v' for VenvSelect
vim.keymap.set("n", "<leader>v", "<cmd>VenvSelect<CR>", { desc = "Opens the VenvSelect menu" })

-- Shortcut to update plugins
create_user_command("Update", "lua vim.pack.update()", "Shortcut: Updates plugins")

create_user_command("Update", function()
  -- Sync and Update existing plugins
  print("Updating plugins...")
  vim.pack.update()

  -- Identify inactive plugins (on disk but not in config)
  local inactive = vim.iter(vim.pack.get())
    :filter(function(p) return not p.active end)
    :map(function(p) return p.spec.name end)
    :totable()

  -- Remove them if any exist
  if #inactive > 0 then
    print("Cleaning up: " .. table.concat(inactive, ", ") .. "...")
    vim.pack.del(inactive)
  else
    print("No inactive plugins to remove.")
  end
  print("Update and Cleanup complete.")
end, "Updates and cleans installed plugins")
