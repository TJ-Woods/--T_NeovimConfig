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
-- Create user command lowercase bind
local function create_user_command(title, cmd, descr)
    local little_title = title:lower()
    vim.api.nvim_create_user_command(title, cmd, { desc = descr })
    vim.cmd("cnoreabbrev <expr> " .. little_title .. " getcmdtype() == ':' && getcmdline() ==# '" .. little_title .. "' ? '" .. title .. "' : '" .. little_title .. "'")
end

--- Keybinds ---

-- Neotree --
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

-- '<A-#>' to move selected (#= jk)
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

-- Expand <CR> Inside Brackets
local function expand_enter()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local char_next = string.sub(line, col + 1, col + 1)
    local char_prev = string.sub(line, col, col)
    local start_brackets = "([{"
    local end_brackets = ")]}"
    local index = string.find(start_brackets, char_prev, 1, true)

    if index and string.sub(end_brackets, index, index) == char_next then
        return "<CR><Esc>O"
    else
        return "<CR>"
    end
end

-- Keymaps
vim.keymap.set("i", "<CR>", function() return expand_enter() end, { desc = "Expand <CR> inside brackets", expr = true, silent = true})
vim.keymap.set("i", "(", "()<left>", { desc = "Close Bracket" })
vim.keymap.set("i", "[", "[]<left>", { desc = "Close Square Bracket" })
vim.keymap.set("i", "{", "{}<left>", { desc = "Close Curly Bracket" })
vim.keymap.set("i", "'", function() return auto_quote("'") end, { desc = "Close Single Quotes", expr = true, silent = true})
vim.keymap.set("i", '"', function() return auto_quote('"') end, { desc = "Close Double Quotes", expr = true, silent = true})
vim.keymap.set("i", "`", function() return auto_quote("`") end, { desc = "Close Backtick Quotes", expr = true, silent = true})

vim.keymap.set("i", ")", function() return skip_closing(")") end, { desc = "Allow Bracket Type-over", expr = true, silent = true})
vim.keymap.set("i", "]", function() return skip_closing("]") end, { desc = "Allow Square Bracket Type-over", expr = true, silent = true})
vim.keymap.set("i", "}", function() return skip_closing("}") end, { desc = "Allow Curly Bracket Type-over", expr = true, silent = true})

-- HTML Specific Keybinds
vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    callback = function()
        vim.keymap.set("i", "<", "<lt>><left>", { desc = "Close Angle Bracket", buffer = true })

        vim.keymap.set("i", ">", function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()

            local char_under_cursor = string.sub(line, col + 1, col + 1)
            local is_writeover = (char_under_cursor == ">")

            local before_cursor = line:sub(1, col)
            local open_bracket = before_cursor:match(".*<")

            if not open_bracket then
                return is_writeover and "<Right>" or ">"
            end

            local tag_content = before_cursor:sub(#open_bracket + 1)
            local tag_name = tag_content:match("^([%w%-]+)")

            local invld_strs = {
                "area", "base", "br", "col", "embed", "hr", "img",
                "input", "link", "meta", "param", "source", "track", "wbr"
            }

            if tag_name and not has(invld_strs, tag_name) then
                vim.schedule(function()
                    local closing_tag = "</" .. tag_name .. ">"
                    vim.api.nvim_put({ closing_tag }, "c", false, true)

                    local move_left = vim.api.nvim_replace_termcodes(string.rep("<Left>", #closing_tag), true, false, true)
                    vim.api.nvim_feedkeys(move_left, "n", true)
                end)
            end

            if is_writeover then
                return "<Right>"
            else
                return ">"
            end

        end, { expr = true, silent = true, buffer = true, desc = "Smart HTML close tag" })
    end
})

-- Expand <CR>
local function html_expand_return()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local char_prev = string.sub(line, col, col)
    local char_next = string.sub(line, col + 1, col + 2)

    if char_prev == ">" and char_next == "</" then
        return "<CR><Esc>O"
    else
        return "<CR>"
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html" },
    callback = function(ev)
        vim.keymap.set(
            "i",
            "<CR>",
            html_expand_return,
            {
                desc = "Expand return on HTML tags",
                expr = true,
                silent = true,
                buffer = ev.buf
            }
        )
    end
})

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

