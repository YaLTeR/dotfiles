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
    config = function()
      require('catppuccin').setup {
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
        ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'rust', 'kdl', 'glsl', 'comment' },
        -- highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<A-o>',
            node_incremental = '<A-o>',
            node_decremental = '<A-i>',
          },
        },
      }
    end,
  },

  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

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
    version = '^4',
    ft = { 'rust' },
  },

  {
    'saecki/crates.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup {}
    end,
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

  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     }
  --   end,
  -- },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup {}
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
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
      }
    end,
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
    version = '0.3.*',
    opts = {
      dependencies_bin = { ['typst-preview'] = 'tinymist' },
    },
    build = function()
      require('typst-preview').update()
    end,
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

  'tpope/vim-eunuch', -- :Rename, etc.
  'tpope/vim-abolish', -- Case conversion, :Subvert
  'tpope/vim-sleuth', -- Heuristic indent options
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
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
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require('multicursor-nvim')
      local tbl = require('multicursor-nvim.tbl')
      local util = require('multicursor-nvim.util')

      mc.setup()

      -- Like mc.matchCursors but preserves visual mode.
      function matchCursorsVisual(pattern)
        mc.action(function(ctx)
          pattern = pattern or vim.fn.input('Match: ')
          if not pattern or pattern == '' then
            return
          end
          local newCursors = {}
          ctx:forEachCursor(function(cursor)
            if cursor:hasSelection() then
              newCursors = tbl.concat(newCursors, cursor:splitVisualLines())
            else
              newCursors[#newCursors + 1] = cursor
              cursor:setMode('v')
            end
          end)
          for _, cursor in ipairs(newCursors) do
            local selection = cursor:getVisualLines()
            local matches = util.matchlist(selection, pattern, {
              userConfig = true,
            })
            local vs = cursor:getVisual()
            for _, match in ipairs(matches) do
              if #match.text > 0 then
                local newCursor = cursor:clone()
                newCursor:setVisual(
                  { vs[1], vs[2] + match.byteidx + #match.text - 1 },
                  { vs[1], vs[2] + match.byteidx }
                )
              end
            end
            cursor:delete()
          end
        end)
      end

      local set = vim.keymap.set

      set({ 'n', 'v' }, '<A-c>', function()
        mc.lineAddCursor(-1)
      end)
      set({ 'n', 'v' }, 'C', function()
        mc.lineAddCursor(1)
      end)

      set('v', '&', mc.alignCursors)
      set({ 'n', 'v' }, ')', mc.nextCursor)
      set({ 'n', 'v' }, '(', mc.prevCursor)
      set('v', '<A-(>', function()
        mc.transposeCursors(-1)
      end)
      set('v', '<A-)>', function()
        mc.transposeCursors(1)
      end)
      set({ 'n', 'v' }, ',', mc.clearCursors)
      set({ 'n', 'v' }, '<A-,>', mc.deleteCursor)
      set('v', '<leader>S', mc.splitCursors)
      set('v', '<leader>s', matchCursorsVisual)

      set('v', 'I', mc.insertVisual)
      set('v', 'A', mc.appendVisual)

      set({ 'v', 'n' }, '<c-i>', mc.jumpForward)
      set({ 'v', 'n' }, '<c-o>', mc.jumpBackward)

      set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Add cursors with mouse
      set('n', '<c-leftmouse>', mc.handleMouse)

      -- Easy way to add and remove cursors using the main cursor
      set({ 'n', 'v' }, '<c-q>', mc.toggleCursor)

      -- Bring back cursors if you accidentally clear them
      set('n', '<leader>gv', mc.restoreCursors)

      -- Add or skip adding a new cursor by matching word/selection
      set({ 'n', 'v' }, '<leader>n', function()
        mc.matchAddCursor(1)
      end)
      set({ 'n', 'v' }, '<leader>kn', function()
        mc.matchSkipCursor(1)
      end)
      set({ 'n', 'v' }, '<leader>N', function()
        mc.matchAddCursor(-1)
      end)
      set({ 'n', 'v' }, '<leader>KN', function()
        mc.matchSkipCursor(-1)
      end)

      -- Add all matches in the document
      set({ 'n', 'v' }, '<leader>A', mc.matchAllAddCursors)

      -- You can also add cursors with any motion you prefer:
      -- set("n", "<right>", function()
      --     mc.addCursor("w")
      -- end)
      -- set("n", "<leader><right>", function()
      --     mc.skipCursor("w")
      -- end)
    end,
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
vim.o.guifont = 'monospace:h10.5' -- Font for GUI frontends
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
end

-- Change signs to colored dots
vim.fn.sign_define('DiagnosticSignError', { text = '●', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '●', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '●', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '●', texthl = 'DiagnosticSignHint' })

vim.keymap.set({ 'n', 'v' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<C-w>l')
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', ':tabnext ' .. i .. '<CR>')
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

require('leap').create_default_mappings()

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
}
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files)
vim.keymap.set('n', '<space>/', telescope_builtin.live_grep)
vim.keymap.set('n', '<space>d', function()
  telescope_builtin.diagnostics { bufnr = 0 }
end)
vim.keymap.set('n', '<space>D', telescope_builtin.diagnostics)
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
require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = {
  'marksman',
  'texlab',
  'pylsp',
  'bashls',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end
lspconfig.clangd.setup {
  capabilities = capabilities,
  cmd = { 'clangd', '--header-insertion=never' },
}
-- lspconfig.typst_lsp.setup {
--   capabilities = capabilities,
--   settings = { exportPdf = 'onType' },
-- }
lspconfig.tinymist.setup {
  capabilities = capabilities,
  root_dir = function(filename, bufnr)
    return vim.fn.getcwd()
  end,
  settings = {
    exportPdf = 'onType',
    systemFonts = true,
    formatterMode = 'typstyle',
  },
  offset_encoding = 'utf-8', -- Work around nvim bug, see https://github.com/Myriad-Dreamin/tinymist/issues/638
}
lspconfig.ltex.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('ltex_extra').setup {
      load_langs = { 'en-US', 'ru-RU' },
      path = vim.fn.expand('~') .. '/.local/share/ltex',
    }
  end,
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
      behavior = cmp.ConfirmBehavior.Replace,
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
vim.g.rustaceanvim = {
  tools = {},
  server = {
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
  },
}
