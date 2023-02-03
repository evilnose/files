vim.cmd('source '..vim.fn.stdpath('config')..'/.vimrc')

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.startify_session_delete_buffers = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_before_save = {'BDelete! hidden'}
vim.api.nvim_command [[set noshowmode]]

-- neovide
vim.opt.guifont = { "", ":h12" }
-- vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = ""


vim.opt.winblend = 10
vim.opt.pumblend = 10
vim.g.neovide_floating_blur = true
vim.g.neovide_floating_blur_amount_x = 5.0
vim.g.neovide_floating_blur_amount_y = 5.0

vim.g.fzf_history_dir = '~/.local/share/fzf-history'


-- Help links
-- How to find and replace: https://github.com/junegunn/fzf.vim/issues/528
-- No need for above anymore with replacer

-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('config')..'/plugged')

Plug('dracula/vim', {as='dracula'})
Plug('sainnhe/sonokai', {as='sonokai'})

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-tree/nvim-tree.lua'
Plug 'mhinz/vim-startify'

Plug 'nvim-tree/nvim-web-devicons'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'numToStr/Comment.nvim'
Plug ('ojroques/vim-oscyank', {branch='main'})

Plug 'kazhala/close-buffers.nvim'

Plug 'crispgm/nvim-tabline'
Plug 'szw/vim-maximizer'

-- not needed if lsp is configured:
-- Plug 'ludovicchabant/vim-gutentags'

Plug 'rhysd/git-messenger.vim'
-- Plug 'stevearc/profile.nvim'

Plug 'folke/trouble.nvim'

-- Plug 'itchyny/lightline.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug('folke/tokyonight.nvim', { branch= 'main' })

Plug 'famiu/bufdelete.nvim'
Plug 'emileferreira/nvim-strict'

Plug 'gabrielpoca/replacer.nvim'
Plug 'levouh/tint.nvim'
-- Plug 'beauwilliams/focus.nvim'
Plug ('akinsho/toggleterm.nvim', {tag= '*'})

-- if COQdeps is having SSL errors trying to install from github, need to add codeload.github.com (and maybe
-- github.com?) as trusted host, in ~/.config/pip/pip.conf:
-- [global]
-- trusted-host = codeload.github.com github.com
Plug ('ms-jpq/coq_nvim', {branch= 'coq'})

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'simrat39/rust-tools.nvim'


vim.call('plug#end')

-- require("focus").setup({excluded_buftypes = {'help', 'nofile', 'prompt', 'popup', 'terminal', 'toggleterm'}})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
end

require('lualine').setup{
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
  },
  inactive_sections = {
    lualine_c = {
      { 'filename', color = 'StatusLine' }
    },
    lualine_x = {
      { 'location', color = 'StatusLine' }
    }
  },
}

require("mason").setup()
require("mason-lspconfig").setup()

-- needs to symlink a compile_commands.json at project root
local lsp = require('lspconfig')
local coq = require('coq')
lsp.clangd.setup({
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    "--background-index",
  },
  on_attach = on_attach
})
lsp.clangd.setup(coq.lsp_ensure_capabilities())

require('rust-tools').setup()


require("trouble").setup {
    -- icons = true,
    -- fold_open = "v", -- icon used for open folds
    -- fold_closed = ">", -- icon used for closed folds
    -- indent_lines = false, -- add an indent guide below the fold icons
    -- signs = {
    --     -- icons / text used for a diagnostic
    --     error = "error",
    --     warning = "warn",
    --     hint = "hint",
    --     information = "info"
    -- },
    -- use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "cpp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript", "gitignore" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run
  -- vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled. These are handled by Neovim right now and will conflict if enabled
    disable = { "gitignore", "c" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("nvim-tree").setup({
  -- sync_root_with_cwd = true,
  -- respect_buf_cwd = true,
  -- update_focused_file = {
  --   enable = true,
  --   update_root = true
  -- },
  -- renderer = {
  --   icons = {
  --     show = {
  --       file = false,
  --       folder = false,
  --       folder_arrow = false,
  --       git = false,
  --     },
  --   },
  -- }
})

require('tabline').setup({
  show_index = true,        -- show tab index
  show_modify = true,       -- show buffer modification indicator
  modify_indicator = '[+]', -- modify indicator
  no_name = '[No name]',    -- no name buffer name
})

require('Comment').setup()

require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
})
-- Color scheme
vim.api.nvim_command [[colorscheme tokyonight]]

require('tint').setup({
  tint = -45,
})

require("toggleterm").setup{
  start_in_insert = false,
  shade_terminals = false,
}

-- vim.opt.termguicolors = true
require('strict').setup({
  deep_nesting = {
      highlight = false, -- non-default
      highlight_group = 'DiffDelete',
      depth_limit = 3,
      ignored_trailing_characters = nil,
      ignored_leading_characters = nil
  },
  overlong_lines = {
      highlight = false, -- non-default
      highlight_group = 'DiffDelete',
      length_limit = 100,
      split_on_save = false -- non-default
  },
  -- trailing_whitespace = {
  --     highlight = true,
  --     highlight_group = 'SpellBad',
  --     remove_on_save = true
  -- },
  trailing_empty_lines = {
      highlight = false,  -- non-default
      highlight_group = 'SpellBad',
      remove_on_save = false -- non-default
  },
  -- space_indentation = {
  --     highlight = false,
  --     highlight_group = 'SpellBad',
  --     convert_on_save = false
  -- },
  tab_indentation = {
      highlight = true,
      highlight_group = 'SpellBad',
      convert_on_save = false  -- non-default
  },
  todos = {
      highlight = true,
      highlight_group = 'DiffAdd'
  }
})

vim.api.nvim_set_keymap('n', '<Leader>r', ':lua require("replacer").run()<cr>', { nowait = true, noremap = true, silent = true })
vim.api.nvim_create_user_command(
  'Rg',
  'call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)',
  {bang = true}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":belowright split<cr><C-w>J:term<cr>:res 15<cr>",
  { noremap = true }
)

-- set layout to classic
vim.api.nvim_set_keymap(
  "n",
  "<leader>j",
  "<C-W>=<C-W>b:res 15<cr>",
  { noremap = true}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>h",
  ":Buffers <cr>!'term:// ",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>l",
  ":SLoad all<cr>",
  { noremap = true }
)

-- First press: show git info on the current line
-- Second press: put git info pane in focus
-- Third press: put git info pane out of focus
vim.api.nvim_set_keymap(
  "n",
  "<leader>g",
  ":GitMessenger<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>w",
  ":q<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>o",
  ":Files<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  ":Rg<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>1",
  "1gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>2",
  "2gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>3",
  "3gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>4",
  "4gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>5",
  "5gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>6",
  "6gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>7",
  "7gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>8",
  "8gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>9",
  "9gt",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>0",
  "10gt",
  { noremap = true }
)

-- Yank to clipboard, even SSH/tmux
vim.api.nvim_set_keymap(
  "v",
  "<leader>Y",
  ":OSCYank<CR>",
  { noremap = true }
)

--- START yanking and pasting using clipboard, for GUI vims
-- normal and visual mode <leader> + p paste
vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  '"+p',
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>p",
  '"+p',
  { noremap = true }
)

-- insert, visual, and terminal mode ctrl+V paste
-- (M+V for terminal to not clash with fzf V-split
vim.api.nvim_set_keymap(
  "i",
  "<C-V>",
  "<C-R>+",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "c",
  "<C-V>",
  "<C-R>+",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "t",
  "<M-v>",
  "<C-\\><C-N>\"+pi",
  { noremap = true }
)

-- normal and visual mode yank and delete
vim.api.nvim_set_keymap(
  "n",
  "<leader>y",
  '"+y',
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>d",
  '"+d',
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>y",
  "\"+y",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>d",
  '"+d',
  { noremap = true }
)
--- END copy and paste

vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ':NvimTreeToggle<CR>',
  { noremap = true }
)

-- window management
vim.api.nvim_set_keymap("n", "<leader>sv", "<C-w>v", { noremap = true }) -- split window vertically
vim.api.nvim_set_keymap("n", "<leader>sh", "<C-w>s", { noremap = true }) -- split window horizontally
vim.api.nvim_set_keymap("n", "<leader>se", "<C-w>=", { noremap = true }) -- make split windows equal width & height
vim.api.nvim_set_keymap("n", "<leader>sm", ":MaximizerToggle<CR>", { noremap = true }) -- make split windows equal width & height
vim.api.nvim_set_keymap("n", "<leader>x", ":close<CR>", { noremap = true }) -- close current window

-- single-char delete and sub should not pollute registers
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true })
vim.api.nvim_set_keymap("n", "s", '"_s', { noremap = true })

-- neovide sends escape sequence in terminal for <S-space> if it's not mapped
vim.api.nvim_set_keymap("t", "<S-space>", '<space>', { noremap = true })


vim.api.nvim_set_keymap("n", "<leader>no", ":nohl<CR>", { noremap = true })

-- when terminal/neovide goes out of focus, dim the current window
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = { "*" },
  callback = function(_)
    require("tint").tint(vim.api.nvim_get_current_win())
  end
})

vim.api.nvim_create_autocmd("FocusGained", {
  pattern = { "*" },
  callback = function(_)
    require("tint").untint(vim.api.nvim_get_current_win())
  end
})

-- diagnostic UI setting
vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticError")
vim.cmd("sign define DiagnosticSignWarn text= texthl=DiagnosticWarn")
vim.cmd("sign define DiagnosticSignInfo text= texthl=DiagnosticInfo")
vim.cmd("sign define DiagnosticSignHint text= texthl=DiagnosticHint")
vim.api.nvim_command [[set signcolumn=yes]]

vim.api.nvim_create_user_command('ReloadInit',
  function()
    vim.cmd('source '..vim.fn.stdpath('config')..'/init.lua')
  end, {nargs=0})

vim.api.nvim_create_user_command('SetFont',
  function(opts)
    vim.opt.guifont = { "", ":h"..tostring(opts.args) }
  end, {nargs=1})

