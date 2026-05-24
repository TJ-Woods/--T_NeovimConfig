local function gh(owner, name)
    -- GitHub link
    return "https://github.com/" .. owner .. "/" .. name
end

local function ghb(owner, name, branch)
    -- GitHub Branch Link
    return {
        src = "https://github.com/" .. owner .. "/" .. name,
        version = branch
    }
end

vim.pack.add({
    gh("nvim-lua", "plenary.nvim"),             -- Dependancy for many plugins
    gh("nvim-treesitter", "nvim-treesitter"),   -- Treesitter
    gh("mofiqul", "vscode.nvim"),               -- Colour theme
    gh("mbbill", "undotree"),                   -- Undotree
    gh("nmac427", "guess-indent.nvim"),         -- Helps with autoindentation
    gh("uga-rosa", "ccc.nvim"),                 -- #000000 rgb(0, 0, 0) <-- This
    gh("linux-cultist", "venv-selector.nvim"),  -- Allows python venv selection
    gh("neogitorg", "neogit"),                  -- Git interface
    gh("folke", "todo-comments.nvim"),          --  TODO: <-- this
    gh("neovim", "nvim-lspconfig"),             -- LSP manager
    gh("williamboman", "mason.nvim"),           -- "
    gh("williamboman", "mason-lspconfig.nvim"), -- "
    gh("nvim-mini", "mini.statusline"),         -- Nicer Status line
    gh("nvim-mini", "mini.icons"),              -- Nicer icons
    gh("nvim-mini", "mini.files"),              -- Better file directory exploration
    gh("OXY2DEV", "markview.nvim"),             -- Markdown Rendering
    ghb("TJ-Woods", "nvim-RunFile", "dev"),     -- Run files with the terminal
    ghb("TJ-Woods", "nvim-StickyNotes", "dev"), -- Sticky Notes
    gh("christoomey", "vim-tmux-navigator"),    -- Vim-Tmux navigation integration
})

-- Start all loaded packages/plugins
vim.cmd("packloadall")

-- Colour scheme set to VSCode (Colour scheme)
vim.cmd("colorscheme vscode")

-- Run files with the terminal
require("RunFile").setup({
    split = "split",
    true_terminal = false,
    py = {
        auto_close = true,
        true_terminal = true,
        terminal_size = 30,
    },
})

-- Sticky notes
require("StickyNotes").setup({
    use_cwd = false,
    relative = "win",
    show_foldcolumn = false,
    exit_key = "q",
})

-- File directory exploration
require("mini.files").setup()

-- Markdown Rendering
require("markview").setup({
    preview = {
        icon_provider = "mini",
    },
})

-- Mini statusline
require("mini.statusline").setup()

-- Guess Indent
require("guess-indent").setup()

-- Enable the following
-- TODO: To Do - This is something that needs to be done
-- NOTE: Note - this is a note
-- OPTIMIZE: Performance - Optimise this
-- TEST: Test - Test this section / this is a test
-- HACK: Hacky code - This is weird
-- WARN: Warning - This isn't working properly
-- FIX:  Fix - This is broken. Please fix it
require("todo-comments").setup()

-- Enable venv-selector (python virtual environments)
require("venv-selector").setup({
    options = {},
    search = {
        venv_folder = {
            command = 'fdfind "/bin/python$" ~/Desktop/Coding/Python/Environments/ --full-path',
        },
        cwd = false,
    }
})

-- Colour Picker and Display
vim.opt.termguicolors = true
require("ccc").setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    }
})

-- Neogit
require("neogit").setup()

-- Mason.nvim Setup (LSP manager)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    handlers = {
        function (server_name)
            require("lspconfig")[server_name].setup({})
        end,
        ["lua_ls"] = function ()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'},
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,
    }
})
