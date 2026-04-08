
local gh = function(owner, name)
    return "https://github.com/" .. owner .. "/" .. name
end

vim.pack.add({
    gh("mofiqul", "vscode.nvim"),
    gh("mbbill", "undotree"),
    gh("nmac427", "guess-indent.nvim"),
    gh("uga-rosa", "ccc.nvim"),
    gh("linux-cultist", "venv-selector.nvim"),
    gh("neogitorg", "neogit"),
    gh("neovim", "nvim-lspconfig"),
    gh("folke", "todo-comments.nvim")
})

vim.cmd("colorscheme vscode")
