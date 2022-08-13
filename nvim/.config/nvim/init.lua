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
        auto_install = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            scope_incremental = "grc",
            node_incremental = "n",
            node_decremental = "m",
        },
    },
    indent = {
        enable = true
    }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

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

local markdown_paste = function(link)
  local curl = require "plenary.curl"

  link = link or vim.fn.getreg "+"

  if not vim.startswith(link, "https://") then
    return
  end

  local request = curl.get(link)
  if not request.status == 200 then
    print "Failed to get link"
    return
  end

  local html_parser = vim.treesitter.get_string_parser(request.body, "html")
  if not html_parser then
    print "Must have html parser installed"
    return
  end

  local tree = (html_parser:parse() or {})[1]
  if not tree then
    print "Failed to parse tree"
    return
  end

  local query = vim.treesitter.parse_query(
    "html",
    [[
      (
       (element
        (start_tag
         (tag_name) @tag)
        (text) @text
       )
       (#eq? @tag "title")
      )
    ]]
  )

  for id, node in query:iter_captures(tree:root(), request.body, 0, -1) do
    local name = query.captures[id]
    if name == "text" then
      local title = vim.treesitter.get_node_text(node, request.body)
      vim.api.nvim_input(string.format("a[%s](%s)", title, link))
      return
    end
  end
end

vim.keymap.set("n", "<leader>mdp", markdown_paste)
