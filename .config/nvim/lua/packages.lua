require ("packer").startup(function()
    use "wbthomason/packer.nvim"
    use  "vimwiki/vimwiki"
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
	    vim.api.nvim_set_keymap("n", "<c-n>", ":Alpha<CR>", { noremap = true})
        end
    }
    use {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate"
    }
end)

