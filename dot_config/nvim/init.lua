-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Should be done before loading lazy
vim.g.mapleader = ' '

require('lazy').setup {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      term_colors = true,
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
    },
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {}
    end,
  },

  {
    'RRethy/base16-nvim',
    priority = 1000,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup {
        ensure_installed = {
          'c',
          'cpp',
          'lua',
          'vim',
          'vimdoc',
          'query',
          'markdown',
          'rust',
          'kdl',
          'glsl',
          'comment',
          'blueprint',
          'regex',
          'vala',
          'meson',
        },
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            return lang ~= 'blueprint' and lang ~= 'kdl' and lang ~= 'vala'
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<A-o>',
            node_incremental = '<A-o>',
            node_decremental = '<A-i>',
          },
        },
        indent = {
          enable = true,
          disable = function(lang, bufnr)
            return lang ~= 'meson'
          end,
        },
      }
    end,
  },

  'neovim/nvim-lspconfig',
  { 'mason-org/mason.nvim', opts = {} },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      automatic_enable = {
        exclude = {
          'rust_analyzer', -- rustaceanvim handles this.
        },
      },
    },
  },

  {
    'nvimtools/none-ls.nvim',
    config = function()
      local nls = require('null-ls')
      nls.setup {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.actionlint,
        },
      }
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '*',
    ft = { 'rust' },
  },

  {
    'saecki/crates.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  'barreiroleo/ltex-extra.nvim',

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lua',
  'FelipeLema/cmp-async-path',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'honza/vim-snippets',

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {
      keymaps = {
        insert = '<C-g>z',
        insert_line = '<C-g>Z',
        normal = 'yz',
        normal_cur = 'yzz',
        normal_line = 'yZ',
        normal_cur_line = 'yZZ',
        visual = 'Z',
        visual_line = 'gZ',
        delete = 'dz',
        change = 'cz',
        change_line = 'cZ',
      },
    },
  },

  'ggandor/leap.nvim',
  'numToStr/Comment.nvim',

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  'nvim-telescope/telescope-ui-select.nvim', -- Telescope for native pickers such as LSP code actions

  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'j-hui/fidget.nvim', opts = { progress = { ignore = { 'ltex' } } } },

  'kaarmu/typst.vim',
  {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '*',
    opts = {
      dependencies_bin = { ['tinymist'] = 'tinymist' },
    },
  },

  'imsnif/kdl.vim',
  'tikhomirov/vim-glsl',
  {
    'preservim/vim-markdown',
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_no_default_key_mappings = 1
    end,
  },
  'tpope/vim-fugitive',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Jump between hunks
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk('prev')
          end
        end)
      end,
    },
  },

  'tpope/vim-eunuch', -- :Rename, etc.
  'tpope/vim-abolish', -- Case conversion, :Subvert
  'tpope/vim-sleuth', -- Heuristic indent options
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      config = {
        shortcut = {
          {
            desc = 'update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            desc = 'niri config',
            group = 'Number',
            action = 'edit ~/.config/niri/config.kdl',
            key = 'n',
          },
          {
            desc = 'nvim config',
            group = 'Number',
            action = 'edit ~/.config/nvim/init.lua',
            key = 'v',
          },
        },
      },
    },
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}

vim.cmd.colorscheme('catppuccin-mocha')
-- vim.cmd.colorscheme 'github_light'
-- vim.cmd.colorscheme 'catppuccin-latte'
-- vim.cmd.colorscheme 'base16-classic-dark'
-- vim.cmd.colorscheme 'alacritty'

vim.o.clipboard = 'unnamedplus' -- Use the system clipboard
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true
vim.o.signcolumn = 'yes' -- Avoid sign column shifting
vim.o.expandtab = true -- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.list = true -- Show whitespace
vim.o.listchars = 'tab:——,trail:·'
vim.o.showbreak = '↪'
vim.o.ignorecase = true -- Smart case search
vim.o.smartcase = true
vim.o.gdefault = true -- /g by default
vim.o.undofile = true -- Persistent undo
vim.o.inccommand = 'split' -- Live preview for :s
vim.o.breakindent = true -- Indent wrapped lines
vim.o.splitbelow = true -- Split down and right
vim.o.splitright = true
vim.o.scrolloff = 1 -- Always show a few characters around the cursor
vim.o.sidescrolloff = 5
vim.o.autoread = true -- Auto reload files on change
vim.o.exrc = true -- Load trusted project-local .nvim.lua
vim.o.spelllang = 'en,ru_yo' -- Spellcheck languages
vim.o.winborder = 'rounded' -- Add border to LSP hover

vim.diagnostic.config { virtual_text = true } -- Show diagnostic messages next to source

-- @normal is used in the custom KDL injection/highlight to override @string
vim.cmd([[highlight link @normal Normal]])

-- Font for GUI frontends
-- vim.o.guifont = 'monospace:h9.7'
-- vim.o.guifont = 'monospace:h10.2'
vim.o.guifont = 'monospace:h10.5'
-- vim.o.guifont = 'monospace:h11.3'
-- vim.o.guifont = 'monospace:h14'
-- vim.o.termguicolors = true  -- Fix some color schemes not displaying (like base16)

-- Map Russian to
vim.o.langmap =
  --   Colemak-DH
  --   'ЙЦУКЕНГШЩЗФЫВАПРОЛДЖЭЯЧСМИТЬ;QWFPBJLUY:ARSTGMNEIO"ZXCDVKH,йцукенгшщзфывапролджэячсмить;qwfpbjluy\\;arstgmneio\'zxcdvkh'
  --   QWERTY
  'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Neovide settings
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.1
  -- vim.g.neovide_normal_opacity = 0.98

  -- Suggested settings to match Alacritty.
  -- This fixes text looking too thin in light themes.
  -- vim.g.neovide_text_gamma = 0.8
  -- vim.g.neovide_text_contrast = 0.1
end

-- Change signs to colored dots
vim.fn.sign_define('DiagnosticSignError', { text = '●', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '●', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '●', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '●', texthl = 'DiagnosticSignHint' })

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank {}
  end,
})

vim.keymap.set({ 'n', 'v', 't' }, '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 'n', 'v', 't' }, '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 'n', 'v', 't' }, '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 'n', 'v', 't' }, '<C-l>', '<C-\\><C-n><C-w>l')
for i = 1, 9 do
  vim.keymap.set({ 'n', 'v', 't' }, '<A-' .. i .. '>', function()
    vim.cmd.tabnext(i)
  end)
end

vim.keymap.set('n', '<C-s>', vim.cmd.update)
vim.keymap.set('n', '<F5>', function()
  vim.cmd.edit('%')
end)
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
vim.keymap.set('n', '<space>t', ':tab terminal /usr/bin/fish<CR>')
vim.keymap.set('n', '<space>j', ':tab terminal jj-fzf<CR>')

vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  callback = function()
    if vim.opt.buftype:get() == 'terminal' then
      vim.cmd.startinsert()
    end
  end,
})

vim.keymap.set('n', '<leader>vps', function()
  vim.cmd([[
    :profile start /tmp/nvim-profile.log
    :profile func *
    :profile file *
  ]])
end)
vim.keymap.set('n', '<leader>vpe', function()
  vim.cmd([[
    :profile stop
    :e /tmp/nvim-profile.log
  ]])
end)

local plenary_profile = require('plenary.profile')
vim.keymap.set('n', '<leader>lps', function()
  print('starting lua profiling')
  plenary_profile.start('/tmp/nvim-profile-flame.log', { flame = true })
end)
vim.keymap.set('n', '<leader>lpe', function()
  plenary_profile.stop()
  vim.system(
    { 'sh', '-c', 'inferno-flamegraph /tmp/nvim-profile-flame.log >/tmp/nvim-profile-flame.svg' },
    { text = true },
    function(obj)
      vim.schedule(function()
        if obj.code == 0 then
          print('flamegraph saved to /tmp/nvim-profile-flame.svg')
        else
          vim.api.nvim_echo({ { obj.stderr } }, true, {})
        end
      end)
    end
  )
end)

require('leap').set_default_mappings()

require('Comment').setup {}
require('Comment.ft').set('spec', '#%s')
vim.keymap.set('n', '<C-c>', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('x', '<C-c>', '<Plug>(comment_toggle_linewise_visual)')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.opt_local.colorcolumn = { 100 }
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'text', 'markdown', 'tex', 'typst' },
  callback = function()
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'kdl' },
  callback = function()
    vim.opt_local.spell = true
  end,
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
    layout_strategy = 'flex',
    layout_config = {
      flip_columns = 180,
      horizontal = { preview_width = { 0.6, max = 100 } },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = { '--hidden' },
    },
  },
}
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files)
vim.keymap.set('n', '<space>/', telescope_builtin.live_grep)
vim.keymap.set('n', '<space>d', function()
  telescope_builtin.diagnostics { bufnr = 0 }
end)
vim.keymap.set('n', '<space>D', telescope_builtin.diagnostics)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>b', telescope_builtin.buffers)

require('lualine').setup {
  sections = {
    lualine_c = {
      'filename',
      {
        'lsp_progress',
        hide = { 'ltex' }, -- Spammy LSPs
        spinner_symbols = { '🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘' },
      },
    },
  },
}

-- LSP

-- These are installed from packages rather than Mason.
vim.lsp.enable { 'clangd', 'vala_ls', 'blueprint_ls', 'qmlls' }

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--header-insertion=never' },
}

vim.lsp.config.qmlls = {
  cmd = { 'qmlls', '-E' },
}

vim.lsp.config.tinymist = {
  root_dir = function(filename, bufnr)
    return vim.fn.getcwd()
  end,
  settings = {
    exportPdf = 'onType',
    systemFonts = true,
    formatterMode = 'typstyle',
  },
}

vim.lsp.config.ltex = {
  on_attach = function(client, bufnr)
    require('ltex_extra').setup {
      load_langs = { 'en-US', 'ru-RU' },
      path = vim.fn.expand('~') .. '/.local/share/ltex',
    }
  end,
}

vim.lsp.config.basedpyright = {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
      },
    },
  },
}

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
    vim.keymap.set('n', '<space>i', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)

    -- Tinymist
    vim.keymap.set('n', '<space>tp', function()
      vim.lsp.buf.execute_command {
        command = 'tinymist.pinMain',
        arguments = { vim.api.nvim_buf_get_name(0) },
      }
    end, opts)
    vim.keymap.set('n', '<space>tu', function()
      vim.lsp.buf.execute_command {
        command = 'tinymist.pinMain',
        arguments = { nil },
      }
    end, opts)
  end,
})

-- Snippets
local luasnip = require('luasnip')
luasnip.setup {
  -- Live-update parts of the snippet when typing
  update_events = { 'TextChanged', 'TextChangedI' },
  -- Visual selection expansion support
  store_selection_keys = '<Tab>',
}
require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_lua').lazy_load()

vim.keymap.set('i', '<Tab>', function()
  -- Try to expand or jump, or fall back to tab
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.cmd('call feedkeys("\\<Tab>", "n")')
  end
end)
vim.keymap.set('s', '<Tab>', luasnip.expand_or_jump)
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  luasnip.jump(-1)
end)
vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

-- Completion
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
  },
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
vim.lsp.config('rust-analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
      rustfmt = { overrideCommand = { 'rustfmt', '+nightly', '--edition=2021' } },
      diagnostics = { disabled = { 'inactive-code' } },
      completion = {
        snippets = {
          custom = {
            ['if let Err(err) ='] = {
              postfix = 'ile',
              body = {
                'if let Err(err) = ${receiver} {',
                '\twarn!("error $0: {err:?}");',
                '}',
              },
            },
            ['let Some(x) else'] = {
              postfix = 'lse',
              body = {
                'let Some($0) = ${receiver} else {',
                '\treturn',
                '};',
              },
            },
            ['match Some, None'] = {
              postfix = 'msn',
              body = {
                'match ${receiver} {',
                '\tSome($1) => {',
                '\t\t$2',
                '\t}',
                '\tNone => {',
                '\t\t$3',
                '\t}',
                '}',
              },
            },
            ['match Ok, Err'] = {
              postfix = 'moe',
              body = {
                'match ${receiver} {',
                '\tOk($1) => {',
                '\t\t$2',
                '\t}',
                '\tErr(err) => {',
                '\t\twarn!("error $3: {err:?}");',
                '\t}',
                '}',
              },
            },
            ['info_span scope'] = {
              postfix = 'iss',
              body = {
                'info_span!("$0").in_scope(|| ${receiver})',
              },
            },
          },
        },
      },
    },
  },
})
