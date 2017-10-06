let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'source ' . s:path . '/plugins.vim'

" Enable true color
set termguicolors

" Use the system clipboard
set clipboard+=unnamedplus

" Add useful stuff to the statusline
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{fugitive#statusline()}

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
" set hidden

" Set up tab and shift-tab to indent and unindent selection
vmap <Tab> >gv
vmap <S-Tab> <gv

" Map CTRL-S to save
nnoremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Mapping for easy search highlight removal
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Better vertical movement in normal and visual modes
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Set leader to ,
let mapleader = ","

" Increase the preview window height
set previewheight=24

" Fix airline delay when exiting insert mode
set ttimeoutlen=10

" Remove some binary output paths from ctrl-p
set wildignore+=*.o,*.dll,*.dylib,*.so,*.a,*.obj,*.rs.bk,*/target/*

" Map F12 to go to definition / declaration
map <F12> :YcmCompleter GoTo<CR>

" Language server stuff
let g:LanguageClient_serverCommands = {
   \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
   \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

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

" Set the colorscheme
" let base16colorspace=256
if empty($BASE16_THEME)
	colorscheme base16-flat
else
	execute "colorscheme base16-".$BASE16_THEME
endif

let color = execute("hi LineNr")
let color = matchstr(color, 'guibg=#\zs[0-9a-fA-F]\+')
execute "hi Whitespace cterm=bold ctermfg=8 gui=bold guifg=#" . color

" Unconditionally load .lvimrc from OpenAG
let g:localvimrc_whitelist='/home/yalter/Source/cpp/OpenAG'

" Disable loading in sandbox
let g:localvimrc_sandbox=0

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Only press leader once
map <Leader> <Plug>(easymotion-prefix)

" Enable deoplete
let g:deoplete#enable_at_startup = 1

let g:vimtex_compiler_latexmk = {
\ 'backend' : 'nvim',
\ 'background' : 1,
\ 'build_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'options' : [
\   '-pdf',
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\   '-lualatex',
\ ],
\}

let g:vimtex_view_method = 'zathura'
let g:vimtex_viewer_general_viewer = 'zathura'

" Nice NERDCommenter style
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" Better binds for nvim-completion-manager
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Make ALE use cargo check
" let g:ale_rust_cargo_use_check = 1

" Binds for ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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
  \   'rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

cnoreabbrev rg Rg
cnoreabbrev rG Rg
cnoreabbrev RG Rg
