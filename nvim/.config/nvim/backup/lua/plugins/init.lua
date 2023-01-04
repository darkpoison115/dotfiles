local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')
--packer.reset()
--packer.init{compile_path=fn.expand('~/.vim/packer/packer_compiled.lua')}

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- vim-cmp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- lint
    use 'mfussenegger/nvim-lint'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use {'nvim-treesitter/playground'}

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'ThePrimeagen/harpoon',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- LuaSnip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Sessions
    use({
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup{ dir=vim.fn.expand('~/.vim/sessions/'), }
        end,
    })

    -- Lua Dev
    -- use '/rafcamlet/nvim-luapad'
    use 'nanotee/luv-vimdocs'
    use "milisims/nvim-luaref"

    use {'dracula/vim', as='dracula'}
    use 'vim-airline/vim-airline'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
