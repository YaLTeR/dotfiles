call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
" Plug 'vim-syntastic/syntastic'
" Plug 'Valloric/YouCompleteMe'
Plug 'chriskempson/base16-vim'
" Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
" Plug 'embear/vim-localvimrc'
Plug 'scrooloose/nerdcommenter'
" Plug 'lyuts/vim-rtags'
Plug 'dag/vim-fish'
Plug 'easymotion/vim-easymotion'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'

if !exists("g:started_on_network_file") || g:started_on_network_file != 1
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh'
      \ }
  " Plug 'YaLTeR/LanguageClient-neovim', {
  "     \ 'branch': 'rls-hover-fix-empty',
  "     \ 'do': 'make release'
  "     \ }
endif

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-ultisnips'

Plug 'ncm2/ncm2-html-subscope'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-rst-subscope'

Plug 'godlygeek/tabular'
" Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
" Plug 'neomake/neomake'
Plug 'chitalu/vim-opencl'
" Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
" Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'takac/vim-hardtime'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'yuttie/comfortable-motion.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'OmniSharp/omnisharp-vim'
" Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'ryanoasis/vim-devicons'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'libclang-vim/libclang-vim', { 'do': 'make' }
Plug 'libclang-vim/vim-textobj-clang'
Plug 'arrufat/vala.vim'
Plug 'igankevich/mesonic'
Plug 'dstein64/vim-startuptime'

Plug 'jceb/vim-orgmode'
Plug 'inkarkat/vim-SyntaxRange'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'

call plug#end()
