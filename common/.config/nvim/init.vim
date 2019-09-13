let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'source ' . s:path . '/plugins.vim'

" Enable true color
set termguicolors

" Set the colorscheme
" let base16colorspace=256
if empty($BASE16_THEME)
        colorscheme base16-ocean
else
        execute "colorscheme base16-".$BASE16_THEME
endif

let color = execute("hi LineNr")
let color = matchstr(color, 'guibg=#\zs[0-9a-fA-F]\+')
execute "hi Whitespace cterm=bold ctermfg=8 gui=bold guifg=#" . color

" Set the GUI font because GNvim doesn't read ginit.vim
set guifont=monospace:h11

" Use the system clipboard
set clipboard+=unnamedplus

" Add useful stuff to the statusline
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
set statusline=
set statusline+=%<%f\ %h%m%r
set statusline+=%{PrependSpace(fugitive#statusline())}
set statusline+=%{PrependSpace(LanguageClient_statusLine())}
set statusline+=%=%-14.(%l,%c%V%)\ %P

function! PrependSpace(string)
  if empty(a:string)
    return ''
  else
    return '  ' . a:string
  endif
endfunction

" Make vim-airline appear always (as opposed to only when a split is created)
set laststatus=2

" Show line numbers
set number
set relativenumber

" Show whitespace
set list listchars=tab:——,trail:·

" Wrapping
set wrap
set showbreak=↪

" Strip trailing whitespace on save
autocmd BufWritePre *.rs :%s/\s\+$//e
" autocmd BufWritePost *.rs Neomake

" Show incomplete commands
set showcmd

" Draw a line at the 100th column
set colorcolumn=100

" Smart case for searching
set ignorecase
set smartcase

" /g by default
set gdefault

" Enable saving undo
set undofile

" Make some space for echodoc
set cmdheight=2

" Required for operations modifying multiple buffers like rename.
set hidden

" Live preview of some commands.
set inccommand=split

" Folding
set foldmethod=syntax
set foldlevelstart=99

" Mouse
set mouse=a

" Don't redraw the screen during macros
set lazyredraw

" Wrapped lines continue visually indented
set breakindent

" Set leader to Space
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" C highlighting settings
let c_gnu = 1
let c_space_errors = 1

" Set up tab and shift-tab to indent and unindent selection
vmap <Tab> >gv
vmap <S-Tab> <gv

" Map CTRL-S to save
nnoremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Mapping for easy search highlight removal
nnoremap <silent> <C-L> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-L>

" Mapping for macro editing
nnoremap <leader>cm :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Better vertical movement in normal and visual modes
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Move between windows with Alt-hjkl
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Map Alt-1..9 to opening the corresponding tab
for n in [1, 2, 3, 4, 5, 6, 7, 8, 9]
  call execute('nnoremap <silent> <A-' . string(n) . '> :tabnext ' . string(n) . '<CR>')
  call execute('inoremap <silent> <A-' . string(n) . '> <C-\><C-N>:tabnext ' . string(n) . '<CR>')
  call execute('tnoremap <silent> <A-' . string(n) . '> <C-\><C-N>:tabnext ' . string(n) . '<CR>')
endfor

" :TT to open a terminal in a new tab
command! TT tabnew | execute 'terminal' | startinsert

" F5 to refresh the current file
nnoremap <F5> :e %<CR>

" Swap ; and :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Map <leader>m to make.
nnoremap <leader>m :make<CR>

" Make Y behave like D.
nnoremap Y y$

" I can use gQ if I really need this.
nnoremap Q @@

" Automatically start inserting in terminal
autocmd BufEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

" Increase the preview window height
" set previewheight=24

" Always show at least one line above/below the cursor
set scrolloff=1
set sidescrolloff=5

" Reload the files automatically on external changes
set autoread

" Fix airline delay when exiting insert mode
set ttimeoutlen=10

" Remove some binary output paths from ctrl-p
set wildignore+=*.o,*.dll,*.dylib,*.so,*.a,*.obj,*.rs.bk,*/target/*

" Highlight stuff in Markdown code blocks.
let g:markdown_fenced_languages = ['c', 'cpp', 'rust', 'python']

nnoremap <leader>v :tab Gstatus<CR>

" Map F12 to go to definition / declaration
noremap <F12> :YcmCompleter GoTo<CR>

" LanguageClient-neovim {{{
let g:LanguageClient_serverCommands = {
   \ 'cpp': ['ccls'],
   \ 'c': ['ccls'],
   \ 'rust': ['ra_lsp_server'],
   \ 'python': ['pyls'],
   \ }
   " \ 'cpp': ['bash', '~/.config/nvim/plugged/LanguageClient-neovim/wrapper-cquery.sh', '--language-server', '--enable-comments'],
   " \ 'c': ['bash', '~/.config/nvim/plugged/LanguageClient-neovim/wrapper-cquery.sh', '--language-server', '--enable-comments'],
   " \ 'rust': ['bash', '~/.config/nvim/plugged/LanguageClient-neovim/wrapper-rls.sh'],
   " \ 'rust': ['rls'],
   " \ 'rust': ['ra_lsp_server'],
   " \ 'haskell': ['hie', '--lsp'],

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Load settings from a global file (a setting is required by cquery).
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = s:path . '/langserver_settings.json'

" Set a short timeout (5 seconds) so the client doesn't hang when servers don't
" respond for some reason. Note that this affects how fast you have to type
" the new name in refactor rename.
let g:LanguageClient_waitOutputTimeout = 5

" Yes I do have my snippets working.
let g:LanguageClient_hasSnippetSupport = 1

" let g:LanguageClient_devel = 1 "Use rust debug build
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile = "/tmp/LanguageClient.log"

" Automatic Hover
function! DoNothingHandler(output)
endfunction

function! ShouldPreventNextAutoHover()
  if !exists('b:prevent_next_auto_hover')
    return 0
  endif

  return b:prevent_next_auto_hover
endfunction

function! IsDifferentHoverLineFromLast()
  if !exists('b:last_hover_line')
    return 1
  endif

  return b:last_hover_line !=# line('.') || b:last_hover_col !=# col('.')
endfunction

function! UpdateLastHoverLine()
  " echomsg "UpdateLastHoverLine() line=" line('.') "col=" col('.')

  let b:last_hover_line = line('.')
  let b:last_hover_col = col('.')
endfunction

function! IsDifferentSignatureHelpLineFromLast()
  if !exists('b:last_signature_help_line')
    return 1
  endif

  return b:last_signature_help_line !=# line('.') || b:last_signature_help_col !=# col('.')
endfunction

function! UpdateLastSignatureHelpLine()
  " echomsg "UpdateLastSignatureHelpLine() line=" line('.') "col=" col('.')

  let b:last_signature_help_line = line('.')
  let b:last_signature_help_col = col('.')
endfunction

function! GetHoverInfo()
  " echomsg "Inside GetHoverInfo(), mode=" mode() "line=" line('.') "col=" col('.')

  if ShouldPreventNextAutoHover()
    let b:prevent_next_auto_hover = 0
    return
  endif

  " Only call hover if the cursor position changed.
  "
  " This is needed to prevent infinite loops, because hover info is displayed
  " in a popup window via nvim_buf_set_lines() which puts the cursor into the
  " popup window and back, which in turn calls CursorMoved again.
  if mode() == 'n' && IsDifferentHoverLineFromLast()
    call UpdateLastHoverLine()

    call LanguageClient_closeFloatingHover()
    call LanguageClient_textDocument_hover({'handle': v:true}, 'DoNothingHandler')
    call LanguageClient_clearDocumentHighlight()
    call LanguageClient_textDocument_documentHighlight({'handle': v:true}, 'DoNothingHandler')
  endif
endfunction

function! GetSignatureHelp()
  " echomsg "Inside GetSignatureHelp()"

  if IsDifferentSignatureHelpLineFromLast()
    call UpdateLastSignatureHelpLine()
    call LanguageClient#textDocument_signatureHelp({'handle': v:true}, 'DoNothingHandler')
  endif
endfunction

augroup LanguageClient_config
  autocmd!
  autocmd CursorMoved * call GetHoverInfo()
  autocmd CursorMovedI * call LanguageClient_clearDocumentHighlight()
  " autocmd CursorMoved * call GetSignatureHelp()
  " autocmd CursorMovedI * call GetSignatureHelp()
augroup end

" Go to definition, but with a fallback in case the language server isn't
" running.
function! GoToDefinitionHandler(output)
  if has_key(a:output, 'error')
    call searchdecl(expand('<cword>'))
  endif
endfunction

function! GoToDefinition()
  call LanguageClient#textDocument_definition({'handle': v:true}, 'GoToDefinitionHandler')
endfunction

nnoremap <silent> gd :call GoToDefinition()<CR>
nnoremap <silent> gi :call LanguageClient_textDocument_implementation()<CR>
nnoremap <silent> gt :call LanguageClient_textDocument_typeDefinition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <C-T> :call LanguageClient_workspace_symbol()<CR>
nnoremap <silent> <F17> :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> <S-F5> :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> <F18> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <S-F6> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <F20> :call LanguageClient#rustDocument_implementations()<CR>
nnoremap <silent> <S-F8> :call LanguageClient#rustDocument_implementations()<CR>
nnoremap <silent> <Leader>= :call LanguageClient_textDocument_formatting()<CR>
vnoremap <silent> <Leader>= :call LanguageClient_textDocument_rangeFormatting()<CR>

" Closing the hover window after the visual selection has started leads to
" loss of the visual selection. So clear it before.
nnoremap <silent> v :call LanguageClient_closeFloatingHover()<CR>v
nnoremap <silent> V :call LanguageClient_closeFloatingHover()<CR>V
nnoremap <silent> <C-V> :call LanguageClient_closeFloatingHover()<CR><C-V>

let g:LanguageClient_diagnosticsDisplay = {
      \   1: {
      \     "name": "Error",
      \     "texthl": "SpellBad",
      \   },
      \   2: {
      \     "name": "Warning",
      \     "texthl": "SpellCap",
      \   },
      \   3: {
      \     "name": "Information",
      \     "texthl": "SpellCap",
      \   },
      \   4: {
      \     "name": "Hint",
      \     "texthl": "SpellCap",
      \   },
      \ }

function! GetColorSettings(group)
  let settings = execute("highlight " . a:group)
  return matchstr(settings, 'xxx \zs.*')
endfunction

function! CopySettingsFrom(target, source)
  let settings = GetColorSettings(a:source)
  call execute("highlight " . a:target . " " . settings)
endfunction

call CopySettingsFrom("VariableRead", "Visual")
call CopySettingsFrom("VariableRead", "SpellLocal")

call CopySettingsFrom("VariableWrite", "Visual")
call CopySettingsFrom("VariableWrite", "SpellRare")

let g:LanguageClient_documentHighlightDisplay = {
      \   1: {
      \     "name": "Text",
      \     "texthl": "Visual",
      \   },
      \   2: {
      \     "name": "Read",
      \     "texthl": "VariableRead",
      \   },
      \   3: {
      \     "name": "Write",
      \     "texthl": "VariableWrite",
      \   },
      \ }
" }}}

" Syntastic recommended defaults
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" For the gradle syntastic plugin
let g:syntastic_java_javac_config_file_enabled = 1

" Use powerline symbols
let g:airline_powerline_fonts=1

" Enable tabline
let g:airline#extensions#tabline#enabled=1

" Some symbol customization
" let g:airline_left_sep='▓▒░'
" let g:airline_right_sep='░▒▓'

" Unconditionally load .lvimrc from OpenAG
let g:localvimrc_whitelist='/home/yalter/Source/cpp/OpenAG'

" Disable loading in sandbox
let g:localvimrc_sandbox=0

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" EasyMotion binds
map <Leader> <Plug>(easymotion-prefix)
nmap S <Plug>(easymotion-s2)

" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Set up vimtex stuff
let g:vimtex_compiler_latexmk = {
\ 'backend' : 'nvim',
\ 'background' : 1,
\ 'build_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'options' : [
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\ ],
\}

" Zathura as the PDF viewer
" let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'evince'

" Okular as the PDF viewer
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'

augroup my_cm_setup
  autocmd!
  " autocmd User CmSetup call cm#register_source({
  "       \ 'name' : 'vimtex',
  "       \ 'priority': 8,
  "       \ 'scoping': 1,
  "       \ 'scopes': ['tex'],
  "       \ 'abbreviation': 'tex',
  "       \ 'cm_refresh_patterns': g:vimtex#re#ncm,
  "       \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
  "       \ })
  autocmd User Ncm2Plugin call ncm2#register_source({
          \ 'name' : 'vimtex',
          \ 'priority': 1,
          \ 'subscope_enable': 1,
          \ 'complete_length': 1,
          \ 'scope': ['tex'],
          \ 'matcher': {'name': 'combine',
          \             'matchers': [
          \                 {'name': 'abbrfuzzy', 'key': 'menu'},
          \                 {'name': 'prefix', 'key': 'word'},
          \             ]},
          \ 'mark': 'tex',
          \ 'word_pattern': '\w+',
          \ 'complete_pattern': g:vimtex#re#ncm,
          \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
          \ })
augroup END

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" Nice NERDCommenter style
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDCreateDefaultMappings = 0

nmap <leader>cc <plug>NERDCommenterComment
nmap <leader>cu <plug>NERDCommenterUncomment
vmap <leader>cc <plug>NERDCommenterComment
vmap <leader>cu <plug>NERDCommenterUncomment

" Make ALE use cargo check
" let g:ale_rust_cargo_use_check = 1

" Binds for ALE
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Enable echodoc
let g:echodoc#enable_at_startup = 1

" Correct FZF colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Map Ctrl-P to FZF
nnoremap <C-P> :Files<CR>

" Rg integration with FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

cnoreabbrev rg Rg
cnoreabbrev rG Rg
cnoreabbrev RG Rg

nnoremap <leader>* :execute "Rg" expand("<cword>")<CR>

" UltiSnips+NCM function parameter expansion

" We don't really want UltiSnips to map these three, but there's no option for
" that so just make it map them to a <Plug> key.
let g:UltiSnipsExpandTrigger       = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpForwardTrigger  = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_back)"

let g:UltiSnipsMappingsToIgnore = [ "SelectModeTab", "ShiftTab" ]

" Try expanding snippet or jumping with UltiSnips and return <Tab> if nothing
" worked.
function! UltiSnipsExpandOrJumpOrTab()
  " echomsg "UltiSnipsExpandOrJumpOrTab()"

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  else
    return "\<Tab>"
  endif
endfunction

function! InsertModeTab()
  " echomsg "InsertModeTab() line=" line('.') "col=" col('.')

  " This mapping seems to always switch the mode to normal briefly which
  " triggers autohover which in turn breaks snippets. To fix this, prevent the
  " next autohover.
  let b:prevent_next_auto_hover = 1

  " First try expanding with ncm2_ultisnips. This does both LSP snippets and
  " normal snippets when there's a completion popup visible.
  return ncm2_ultisnips#expand_or("\<Plug>(ultisnips_try_expand)")
endfunction

function! SelectModeTab()
  " echomsg "SelectModeTab() line=" line('.') "col=" col('.')

  " This mapping seems to always switch the mode to normal briefly which
  " triggers autohover which in turn breaks snippets. To fix this, prevent the
  " next autohover.
  let b:prevent_next_auto_hover = 1

  call UltiSnips#ExpandSnippetOrJump()
endfunction

function! ShiftTab()
  " echomsg "ShiftTab() line=" line('.') "col=" col('.')

  " This mapping seems to always switch the mode to normal briefly which
  " triggers autohover which in turn breaks snippets. To fix this, prevent the
  " next autohover.
  let b:prevent_next_auto_hover = 1

  return UltiSnips#JumpBackwards()
endfunction

" Mapping for expanding snippets, jumping forwards in snippets or inserting
" Tab if nothing else worked.
inoremap <silent> <expr> <Tab> InsertModeTab()

" If that failed, try the UltiSnips expand or jump function. This handles
" short snippets when the completion popup isn't visible yet as well as
" jumping forward from the insert mode. Writes <Tab> if there is no special
" action taken.
inoremap <silent> <Plug>(ultisnips_try_expand) <C-R>=UltiSnipsExpandOrJumpOrTab()<CR>

" Select mode mapping for jumping forward with <Tab>.
snoremap <silent> <Tab> <Esc>:call SelectModeTab()<cr>

" Mappings for jumping backward.
inoremap <silent> <S-Tab> <C-R>=ShiftTab()<CR>
snoremap <silent> <S-Tab> <Esc>:call ShiftTab()<CR>

" Visual mode mapping for expanding visual snippets.
xnoremap <silent> <Tab> :call UltiSnips#SaveLastVisualSelection()<cr>gvs

" Startify
let g:startify_session_persistence = 1
let g:startify_fortune_use_unicode = 1
let g:startify_bookmarks = [
  \ '~/.config/nvim/init.vim',
  \ '~/.config/nvim/plugins.vim'
  \ ]

let g:startify_session_before_save = [
  \ 'silent! pclose',
  \ 'silent! TagbarClose',
  \ ]

" Netrw
let g:netrw_bufsettings = "noma nomod nonu nowrap ro nobl relativenumber"

" nvim-completion-manager
" let g:cm_matcher =
" \ { 'module': 'cm_matchers.fuzzy_matcher',
"   \ 'case':   'smartcase' }

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
" Causes LanguageClient integration to not work right away.
" autocmd InsertEnter * call ncm2#enable_for_buffer()
" Start with a timeout (you used to need this to prevent an error in
" nvim-gtk).
" function! s:ncm2_start(...)
"     if v:vim_did_enter
"         call ncm2#enable_for_buffer()
"     endif
"     autocmd BufEnter * call ncm2#enable_for_buffer()
" endfunc
" call timer_start(500, function('s:ncm2_start'))

set completeopt=noinsert,menuone,noselect
set shortmess+=c

" Enable hardtime.
" let g:hardtime_default_on = 1

" https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && empty(getbufvar(v:val, "&buftype"))')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction

let g:discord_blacklist = ['/home/yalter/Stuff/mnt/.*', '/home/YaLTeR/Stuff/mnt/.*']
let g:rooter_manual_only = 1
let g:comfortable_motion_interval = 1000.0 / 144
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

nnoremap <leader>ot :Tagbar<CR>
let g:tagbar_left = 1
let g:tagbar_show_linenumbers = 2
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" OmniSharp
let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_loglevel = 'debug'

augroup OmniSharpSettings
  autocmd!
  autocmd FileType cs nmap <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <buffer> gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <buffer> <F17> <Plug>(omnisharp_code_actions)
  autocmd FileType cs nmap <buffer> <S-F5> <Plug>(omnisharp_code_actions)
  autocmd FileType cs vnoremap <buffer> <silent> <F17> :call OmniSharp#GetCodeActions('visual')<CR>
  autocmd FileType cs vnoremap <buffer> <silent> <S-F5> :call OmniSharp#GetCodeActions('visual')<CR>
  autocmd FileType cs nmap <buffer> <F18> <Plug>(omnisharp_rename)
  autocmd FileType cs nmap <buffer> <S-F6> <Plug>(omnisharp_rename)
  autocmd FileType cs nmap <buffer> <Leader>= <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <buffer> <C-T> <Plug>(omnisharp_find_symbols)

  autocmd FileType cs setlocal makeprg=dotnet\ build
  autocmd FileType cs setlocal errorformat=%f(%l\\,%c):\ error\ CS%n:\ %m\ [%.%#],%-G%.%#

  autocmd User Ncm2Plugin call ncm2#register_source({
          \ 'name' : 'OmniSharp',
          \ 'priority': 9,
          \ 'subscope_enable': 1,
          \ 'scope': ['cs'],
          \ 'mark': 'cs',
          \ 'word_pattern': '[\w\-]+',
          \ 'complete_pattern': '.',
          \ 'on_complete': ['ncm2#on_complete#omni', 'OmniSharp#Complete'],
          \ })
augroup END

let g:highlightedyank_highlight_duration = 250

let g:EditorConfig_preserve_formatoptions = 1
