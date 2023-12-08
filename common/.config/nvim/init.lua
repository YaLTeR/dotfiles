-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Should be done before loading lazy
vim.g.mapleader = ' '

require('lazy').setup({
  {
    'catppuccin/nvim', name = 'catppuccin', priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          native_lsp = {
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
        },
      }
    end,
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {}
    end,
  },

  'neovim/nvim-lspconfig',
  'simrat39/rust-tools.nvim',

  {
    'saecki/crates.nvim', version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup {}
    end,
  },

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lua',
  'FelipeLema/cmp-async-path',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'honza/vim-snippets',

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function ()
      require('copilot_cmp').setup {}
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
        require('nvim-surround').setup {}
    end,
  },

  'ggandor/leap.nvim',
  'numToStr/Comment.nvim',

  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
     dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },

  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  'WhoIsSethDaniel/lualine-lsp-progress',

  'imsnif/kdl.vim',
  'tpope/vim-fugitive',
})

vim.cmd.colorscheme 'catppuccin'
-- vim.cmd.colorscheme 'github_light'

vim.o.clipboard = 'unnamedplus'  -- Use the system clipboard
vim.o.number = true  -- Show line numbers
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'  -- Avoid sign column shifting
vim.o.expandtab = true  -- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.list = true  -- Show whitespace
vim.o.listchars = 'tab:——,trail:·'
vim.o.showbreak = '↪'
vim.o.ignorecase = true  -- Smart case search
vim.o.smartcase = true
vim.o.gdefault = true  -- /g by default
vim.o.undofile = true  -- Persistent undo
vim.o.inccommand = 'split'  -- Live preview for :s
vim.o.breakindent = true  -- Indent wrapped lines
vim.o.splitbelow = true  -- Split down and right
vim.o.splitright = true
vim.o.scrolloff = 1  -- Always show a few characters around the cursor
vim.o.sidescrolloff = 5
vim.o.autoread = true  -- Auto reload files on change
vim.o.exrc = true  -- Load trusted project-local .nvim.lua
vim.o.spelllang = 'en,ru_yo'  -- Spellcheck languages

vim.keymap.set({ 'n', 'v' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<C-w>l')
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', ':tabnext ' .. i .. '<CR>')
end

vim.keymap.set('n', '<C-s>', vim.cmd.update)
vim.keymap.set('n', '<F5>', function() vim.cmd.edit '%' end)
vim.keymap.set('n', 'U', vim.cmd.redo)
vim.keymap.set('n', '<A-l>', ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-L>')
vim.keymap.set('n', '<A-z>', ':set invwrap<CR>')
vim.keymap.set('n', 'Q', '@@')
vim.keymap.set({ 'n', 'x', 'o' }, 'gl', '$')
vim.keymap.set({ 'n', 'x', 'o' }, 'gh', '0')
vim.keymap.set({ 'n', 'x', 'o' }, 'ge', 'G')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.keymap.set('n', '<space>g', ':tab Git<CR>')

require('leap').add_default_mappings()

require('Comment').setup {}
require('Comment.ft').set('spec', '#%s')
vim.keymap.set('n', '<C-c>', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('x', '<C-c>', '<Plug>(comment_toggle_linewise_visual)')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.opt_local.colorcolumn = { 100 }
  end
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'text', 'markdown', 'tex'},
  callback = function()
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end
})

local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local telescope_builtin = require('telescope.builtin')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close,
        ['<C-down>'] = telescope_actions.cycle_history_next,
        ['<C-up>'] = telescope_actions.cycle_history_prev,
      },
    },
  }
}
telescope.load_extension('fzf')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files)
vim.keymap.set('n', '<space>/', telescope_builtin.live_grep)
vim.keymap.set('n', '<space>d', function() telescope_builtin.diagnostics {bufnr=0} end)
vim.keymap.set('n', '<space>D', telescope_builtin.diagnostics)
vim.keymap.set('n', '<space>b', telescope_builtin.buffers)

require('lualine').setup {
  sections = {
    lualine_c = {
      'filename',
      {
        'lsp_progress',
        hide = { 'ltex' },  -- Spammy LSPs
        spinner_symbols = { '🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘' },
      },
    },
  },
}

-- LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = {
  'clangd',
  'marksman',
  'ltex',
  'texlab',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', 'gy', telescope_builtin.lsp_type_definitions, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
    vim.keymap.set('n', '<space>s', telescope_builtin.lsp_document_symbols, opts)
    vim.keymap.set('n', '<space>S', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Snippets
local luasnip = require 'luasnip'
luasnip.setup {
  -- Live-update parts of the snippet when typing
  update_events = {"TextChanged", "TextChangedI"},
  -- Visual selection expansion support
  store_selection_keys = "<Tab>",
}
require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_lua').lazy_load()

vim.keymap.set('i', '<Tab>', function()
  -- Try to expand or jump, or fall back to tab
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.cmd 'call feedkeys("\\<Tab>", "n")'
  end
end)
vim.keymap.set('s', '<Tab>', luasnip.expand_or_jump)
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function() luasnip.jump(-1) end)
vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

-- Completion
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
  }),
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'async_path' },
    { name = 'nvim_lua' },
    { name = 'crates' },
  },
}

-- Rust LSP
local rt = require('rust-tools')
rt.setup({
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
  server = {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        check = { command = 'clippy' },
        rustfmt = { overrideCommand = { 'rustfmt', '+nightly', '--edition=2021' } },
        diagnostics = { disabled = { 'inactive-code' } },
        completion = { snippets = { custom = {
          ['if let Err(err) ='] = {
            postfix = 'ile',
            body = {
              "if let Err(err) = ${receiver} {",
              "\twarn!(\"error $0: {err:?}\");",
              "}",
            }
          },
          ['let Some(x) else'] = {
            postfix = 'lse',
            body = {
              "let Some($0) = ${receiver} else {",
              "\treturn",
              "};",
            }
          },
          ['match Some, None'] = {
            postfix = 'msn',
            body = {
              "match ${receiver} {",
              "\tSome($1) => {",
              "\t\t$2",
              "\t}",
              "\tNone => {",
              "\t\t$3",
              "\t}",
              "}",
            }
          },
          ['match Ok, Err'] = {
            postfix = 'moe',
            body = {
              "match ${receiver} {",
              "\tOk($1) => {",
              "\t\t$2",
              "\t}",
              "\tErr(err) => {",
              "\t\twarn!(\"error $3: {err:?}\");",
              "\t}",
              "}",
            }
          },
          ['info_span scope'] = {
            postfix = 'iss',
            body = {
              "info_span!(\"$0\").in_scope(|| ${receiver})",
            }
          },
        } } },
      }
    }
  },
})
