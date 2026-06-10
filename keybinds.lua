-- Functions --
-- if <table> has <value>
local function has(tbl, val)
    for _, value in ipairs(tbl) do
        if value == val then
            return true
        end
    end
    return false
end

-- if <string> has <char>
local function has_s(s, char)
    for c in s:gmatch(".") do
        if c == char then
            return true
        end
    end
    return false
end

-- Create user command lowercase bind
local function create_user_command(title, cmd, descr)
    local little_title = title:lower()
    vim.api.nvim_create_user_command(title, cmd, { desc = descr })
    vim.cmd("cnoreabbrev <expr> " .. little_title .. " getcmdtype() == ':' && getcmdline() ==# '" .. little_title .. "' ? '" .. title .. "' : '" .. little_title .. "'")
end

--- Keybinds ---

-- Neotree
vim.keymap.set("n", "<leader>-", "<cmd>Neotree<CR>", { desc = "Opens Neotree" })
create_user_command("Nt", "Neotree", "Opens Neotree")

-- 'kj' for exit insert/visual mode
vim.keymap.set( { "i", "v" }, "kj", "<Esc>" )

-- escapes for enter normal mode in terminal
vim.keymap.set("t", "kj", "<c-\\><c-n>", { desc = "Enter normal mode in terminal" })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Enter normal mode in terminal" })

-- '<leader>vs' '<leader>vh' for vsplit and split
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "vsplit" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "split" })

-- 'vse' to vsplit and explore
create_user_command("Vse", "vsplit | Neotree", "Vsplits and exits to explorer")

-- 'we' to save and explore
create_user_command("We", "write | Neotree", "Writes and exits to explorer")

-- '<esc>' to escape hl
vim.keymap.set("n", "<Esc>", "<Cmd>nohl<Cr>", { desc = "Escape hl" })

-- splt / vsplt to open terminal in split or vsplit window
create_user_command("Splt", "split | terminal", "splits and opens terminal")
create_user_command("Vsplt", "vsplit | terminal", "vsplits and opens terminal")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to system cliyboard" })

-- Run Files in the terminal
vim.keymap.set("n", "<A-r>", "<cmd>RunFile<CR>", { desc = "Run files in the terminal" })

-- '<leader>v' for VenvSelect
vim.keymap.set("n", "<leader>v", "<cmd>VenvSelect<CR>", { desc = "Opens the VenvSelect menu" })

-- Shortcut to update plugins
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

-- Nvim-Tmux navigation integration --
local smart_splits = require('smart-splits')
-- Moving between splits/panes
vim.keymap.set('n', '<C-h>', function()
  smart_splits.move_cursor_left({ at_edge = "stop" })
end, { desc = "Go to left window" })

vim.keymap.set('n', '<C-j>', function()
  smart_splits.move_cursor_down({ at_edge = "stop" })
end, { desc = "Go to bottom window" })

vim.keymap.set('n', '<C-k>', function()
  smart_splits.move_cursor_up({ at_edge = "stop" })
end, { desc = "Go to top window" })

vim.keymap.set('n', '<C-l>', function()
  smart_splits.move_cursor_right({ loop_at_edge = false })
end, { desc = "Go to right window" })

-- Resizing splits/panes
vim.keymap.set("n", "<C-Left>",  function() smart_splits.resize_left() end,  { desc = "Resize window left" })
vim.keymap.set("n", "<C-Down>",  function() smart_splits.resize_down() end,  { desc = "Resize window down" })
vim.keymap.set("n", "<C-Up>",    function() smart_splits.resize_up() end,    { desc = "Resize window up" })
vim.keymap.set("n", "<C-Right>", function() smart_splits.resize_right() end, { desc = "Resize window right" })

