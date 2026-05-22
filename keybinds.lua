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

-- Block typing QoL --
-- Allow bracket type-over
local function skip_closing(closing_char)
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local char_under_cursor = string.sub(line, col + 1, col + 1)

    if char_under_cursor == closing_char then
        return '<Right>'
    else
        return closing_char
    end
end

-- Close Quotes, allow type-over
local function auto_quote(quote_char)
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local char_under_cursor = string.sub(line, col + 1, col + 1)

  if char_under_cursor == quote_char then
    return '<Right>'
  else
    return quote_char .. quote_char .. '<Left>'
  end
end

-- Expand <Return> Inside Brackets
local function expand_enter()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local char_next = string.sub(line, col + 1, col + 1)
    local char_prev = string.sub(line, col, col)
    local start_brackets = "([{"
    local end_brackets = ")]}"
    local index = string.find(start_brackets, char_prev, 1, true)

    if index and string.sub(end_brackets, index, index) == char_next then
        return "<return><return><up><tab>"
    else
        return "<return>"
    end
end

-- Keymaps
vim.keymap.set("i", "<return>", function() return expand_enter() end, { desc = "Expand <Return> inside brackets", expr = true, silent = true})
vim.keymap.set("i", "(", "()<left>", { desc = "Close Bracket" })
vim.keymap.set("i", "[", "[]<left>", { desc = "Close Square Bracket" })
vim.keymap.set("i", "{", "{}<left>", { desc = "Close Curly Bracket" })
vim.keymap.set("i", "'", function() return auto_quote("'") end, { desc = "Close Single Quotes", expr = true, silent = true})
vim.keymap.set("i", '"', function() return auto_quote('"') end, { desc = "Close Double Quotes", expr = true, silent = true})
vim.keymap.set("i", "`", function() return auto_quote("`") end, { desc = "Close Backtick Quotes", expr = true, silent = true})

vim.keymap.set("i", ")", function() return skip_closing(")") end, { desc = "Allow Bracket Type-over", expr = true, silent = true})
vim.keymap.set("i", "]", function() return skip_closing("]") end, { desc = "Allow Square Bracket Type-over", expr = true, silent = true})
vim.keymap.set("i", "}", function() return skip_closing("}") end, { desc = "Allow Curly Bracket Type-over", expr = true, silent = true})
vim.api.nvim_create_autocmd( "BufEnter", {
    pattern = { "*.html" },
    callback = function()
        vim.keymap.set("i", "<", "<lt>><left>", { desc = "Close Angle Bracket" , buf=0})
        vim.keymap.set("i", ">", function() return skip_closing(">") end, { expr = true, silent = true})
    end
})
