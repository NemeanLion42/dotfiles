require("vimconf")
require("keybindings")
require("packages")

-- Treesitter Config --
require"nvim-treesitter.configs".setup {
    highlight = {
	enable = true,
    },
    indent = {
	enable = true,
    }
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local function blah()
    print "hello world"
end

