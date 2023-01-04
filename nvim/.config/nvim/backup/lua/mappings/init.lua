function select_configuration_file()
vim.ui.select({ 'init.lua', 'plugins', 'mappings', 'lsp-config', 'settings'}, {
    prompt = 'Select configuration file:',
    format_item = function(item)
        return "I'd like to choose " .. item
    end,
}, function(choice)
    if choice == nil then return end
    if choice == 'init.lua' then
        vim.cmd(':e ~/.config/nvim/init.lua')
    else
        vim.cmd(':e ~/.config/nvim/lua/' .. choice .. '/init.lua')
    end
end)
end

vim.keymap.set('n', '<leader>ev', select_configuration_file, {desc='select a configuration file'})

-- restore the session for the current directory
vim.keymap.set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])

-- restore the last session
vim.keymap.set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]])

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])

vim.keymap.set("n", "<leader>l", "<CMD>cnext<CR>")
vim.keymap.set("n", "<leader>h", "<CMD>cprev<CR>")
vim.keymap.set("n", "<leader>cc", "<CMD>ccl<CR>")
