local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Packer can manage itself


    { 'nvim-telescope/telescope.nvim', version = '0.1.5',
    -- or                            , branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} }
},


{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
'theprimeagen/harpoon',
'mbbill/undotree',
'tpope/vim-fugitive',

{'williamboman/mason.nvim'},
{'williamboman/mason-lspconfig.nvim'},

{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

"rebelot/kanagawa.nvim"
})
