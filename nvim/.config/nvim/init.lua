require('settings')
require('plugins')
require('lsp-config')
require('mappings')

vim.cmd('colorscheme dracula')

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "python" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.cmd [[
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost /home/andres/.config/nvim/lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]])
