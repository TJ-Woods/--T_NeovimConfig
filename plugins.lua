
local function gh(owner, name)
    return "https://github.com/" .. owner .. "/" .. name
end

vim.pack.add({
    gh("nvim-lua", "plenary.nvim"),             -- Dependancy for many plugins
    gh("mofiqul", "vscode.nvim"),               -- Colour theme
    gh("mbbill", "undotree"),                   -- Undotree
    gh("nmac427", "guess-indent.nvim"),         -- Helps with autoindentation
    gh("uga-rosa", "ccc.nvim"),                 -- Colour picker and display e.g. #000000 rgb(0, 0, 0) <-- This
    gh("linux-cultist", "venv-selector.nvim"),  -- Allows python venv selection
    gh("neogitorg", "neogit"),                  -- Git interface
    gh("folke", "todo-comments.nvim"),          -- TODO: <-- this
    gh("neovim", "nvim-lspconfig"),             -- LSP manager
    gh("williamboman", "mason.nvim"),           -- "
    gh("williamboman", "mason-lspconfig.nvim"), -- "
    gh("tpope", "vim-abolish"),                 -- Case-Preserving text replacements
    gh("nvim-mini", "mini.statusline"),         -- Nicer Status line
    gh("TJ-Woods", "nvim-RunFile"),             -- Run files with the terminal
})

-- Start all loaded packages/plugins
vim.cmd("packloadall")

-- Colour scheme set to VSCode (Colour scheme)
vim.cmd("colorscheme vscode")

-- Run files with the terminal
require("RunFile").setup( {
    cleaup = true,
})

-- Mini statusline
require("mini.statusline").setup()

-- Guess Indent
require("guess-indent").setup()

-- Enable the following
-- TODO: To Do - This is something that needs to be done
--  Thing to do is also highlighted if next line is a comment
-- NOTE: Note - this is a note
-- OPTIMIZE: Performance - Optimise this
-- TEST: Test - Test this section / this is a test
-- HACK: Hacky code - This is weird
-- WARN: Warning - This isn't working properly
-- FIX:  Fix - This is broken. Please fix it
require("todo-comments").setup()

-- Enable venv-selector (python virtual environments)
require("venv-selector").setup()

-- FIX:
-- Colour Picker and Display
require("ccc") .setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
    preserve = true,
})

-- Abolish (text capitalisation autocmds)
-- require("vim-abolish").setup()

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
