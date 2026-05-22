
local function create_shortcut(dir, cmd, descr)
    local little_cmd = cmd:lower()
    vim.api.nvim_create_user_command(cmd, "Explore " .. dir, { desc = descr })
    vim.cmd("cnoreabbrev <expr> " .. little_cmd .. " getcmdtype() == ':' && getcmdline() ==# '" .. little_cmd .. "' ? '" .. cmd .. "' : '" .. little_cmd .. "'")
end


-- Tconfig
create_shortcut("~/.config/nvim/lua/--T/", "Tconfig", "Explores the nvim/lua/--T directory")

-- Pythondir
create_shortcut("~/Desktop/Coding/Python/", "Pythondir", "Explores the Coding/Python directory")
create_shortcut("~/Desktop/Coding/Python/", "Pydir", "Explores the Coding/Python directory")

-- Cdir
create_shortcut("~/Desktop/Coding/C/", "Cdir", "Explores the Coding/C directory")

-- Plugins
create_shortcut("~/Desktop/Coding/Lua/Neovim/Plugins/", "Plugin", "Explores the Lua/Neovim/Plugins directory")
