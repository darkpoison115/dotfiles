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
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding xor succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
--    require("lint").try_lint()
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
