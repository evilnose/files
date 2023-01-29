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
-- Doesn't work on Mac for now. See https://github.com/neovide/neovide/issues/1675
-- vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = ""


vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.g.neovide_floating_blur = true
vim.g.neovide_floating_blur_amount_x = 5.0
vim.g.neovide_floating_blur_amount_y = 5.0

vim.g.fzf_history_dir = '~/.local/share/fzf-history'
-- vim.g.lightline = {
--   colorscheme = 'tokyonight',
--    active = {
--      left = { { 'mode', 'paste' },
--      { 'gitbranch', 'readonly', 'filename', 'modified' },
--      -- { 'cwd' },
--      { 'refresh' },
--    },
--    },
--    component_function = {
--      gitbranch = 'FugitiveHead',
--      refresh = 'what'
--    },
--    component = {
--      cwd='%{getcwd()}',
--    },
-- }


-- Help links
-- How to find and replace: https://github.com/junegunn/fzf.vim/issues/528
-- No need for above anymore with replacer

-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('config')..'/plugged')

Plug('dracula/vim', {as='dracula'})
Plug('sainnhe/sonokai', {as='sonokai'})

Plug 'neovim/nvim-lspconfig'

-- Plug 'nvim-tree/nvim-web-devicons' -- optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'mhinz/vim-startify'

Plug 'nvim-tree/nvim-web-devicons'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'numToStr/Comment.nvim'
Plug('ojroques/vim-oscyank', {branch='main'})

Plug 'kazhala/close-buffers.nvim'

Plug 'crispgm/nvim-tabline'

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

vim.call('plug#end')

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

local function defined(s)
  return s ~= nil
end

require('lualine').setup{
  options = {
    -- icons_enabled = defined(vim.g.neovide),
    icons_enabled = true,
  }
}
-- needs to symlink a compile_commands.json at project root
require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    "--background-index",
  },
  on_attach = on_attach
})

require("trouble").setup {
    -- icons = false,
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
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}

-- empty setup using defaults
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      },
    },
  }
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
  "<leader>te",
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
  ":Buffers<cr>",
  { noremap = true }
)

-- START Kaonashi specific
vim.api.nvim_set_keymap(
  "n",
  "<leader>lk",
  ":SLoad kaonashi<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>lo",
  ":SLoad otherkn<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ld",
  ":SLoad deployment<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  ":SLoad all<cr>",
  { noremap = true }
)

-- END Kaonashi specific

-- Yank to clipboard, even SSH
vim.api.nvim_set_keymap(
  "v",
  "<leader>y",
  ":OSCYank<CR><cr>",
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
  "<leader>t",
  ":tabnew ",
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
  "<leader>p",
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

vim.api.nvim_set_keymap(
  "i",
  "<D-v>",
  "<esc>\"+pi",
  { noremap = true }
)

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
