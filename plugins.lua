local function gh(repo)
    -- GitHub link
    return "https://github.com/" .. repo
end

local function ghb(repo, branch)
    -- GitHub Branch Link
    return {
        src = "https://github.com/" .. repo,
        version = branch
    }
end

vim.pack.add({
    gh("nvim-lua/plenary.nvim"),             -- Dependancies
    gh("MunifTanjim/nui.nvim"),              -- "
    gh("nvim-treesitter/nvim-treesitter"),   -- "
    gh("neovim/nvim-lspconfig"),             -- LSP manager
    gh("williamboman/mason.nvim"),           -- "
    gh("williamboman/mason-lspconfig.nvim"), -- "
    gh("mofiqul/vscode.nvim"),               -- Colour theme
    gh("mbbill/undotree"),                   -- Undotree
    gh("uga-rosa/ccc.nvim"),                 -- #000000 rgb(0, 0, 0) <-- This
    gh("linux-cultist/venv-selector.nvim"),  -- Allows python venv selection
    gh("folke/todo-comments.nvim"),          --  TODO: <-- this
    gh("nvim-mini/mini.statusline"),         -- Nicer Status line
    gh("nvim-mini/mini.icons"),              -- Nicer icons
    gh("nvim-neo-tree/neo-tree.nvim"),       -- Better File Explorer
    gh("OXY2DEV/markview.nvim"),             -- Markdown Rendering
    ghb("TJ-Woods/nvim-RunFile", "dev"),     -- Run files with the terminal
    ghb("TJ-Woods/nvim-StickyNotes", "dev"), -- Sticky Notes
    gh("mrjones2014/smart-splits.nvim"),     -- nvim-tmux navigation integration
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

-- Nvim-Tmux navigation integration
require("smart-splits").setup({
    wrap_at_cycle = false,
    at_edge = "stop",
    default_amounts = {
        left = 3,
        right = 3,
        up = 1,
        down = 1,
    },
    disable_multiplexer_nav_when_zoomed = true,
})


-- File directory exploration
require("neo-tree").setup({
    filesystem = {
        hijack_newtrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
        },
    },
    window = {
        position = "current",
    },
    default_component_configs = {
        git_status = {
            symbols = {
                -- Change Type
                added = "+",
                delted = "-",
                modified = "~",
                renamed = '"',
                -- Status Type
                untracked = "?",
                ignored = "/",
                unstaged = "u",
                staged = "✓",
                conflict = "!",
            },
        },
    },
})

-- Markdown Rendering
require("markview").setup({
    preview = {
        icon_provider = "mini",
    },
})

-- Mini statusline
require("mini.statusline").setup()

-- Guess Indent
-- require("guess-indent").setup()

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
