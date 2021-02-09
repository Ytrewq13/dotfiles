" TODO: organise this file
" Move parts into seperate files:
"   - Keybinds          (  keybinds.vim )
"   - Plugins           (  plugins.vim  )
"   - Plugin configs    (  plugconf.vim )
"   - Other configs     (  Leave here   )

set nocompatible
filetype off

augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ap/vim-css-color'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dense-analysis/ale'
Plugin 'wesQ3/vim-windowswap'

" Agda - a dependently typed language used for assisting in writing proofs
" Remove this plugin when finished with agda - it conflicts with ultisnips
Plugin 'derekelkins/agda-vim'
" Coq - a theorem prover / proof assistant, similar to Agda (but more focused
" on writing proofs specifically, and more widely used).
Plugin 'whonore/Coqtail'

" Document formatting packages
Plugin 'lervag/vimtex'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'

" UltiSnips - used to implement snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
call vundle#end()


call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Fuzzy search the current file with <C-/> (vim registers this as <C-_>)
nnoremap <C-_> :BLines<CR>


" UltiSnips configuration
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
inoremap <F5> <Esc>:Snippets<CR>
" Snippet name information (to fill in on certain snippets which use them)
let g:snips_author="Sam Whitehead"
let g:snips_email="sam.everythingcomputers@gmail.com"
let g:snips_github="https://github.com/Ytrewq13"


let g:rooter_silent_chdir = 1


filetype plugin indent on
syntax on

let mapleader="\\"
let maplocalleader="\\"

set path+=**
set wildmenu
set wildignore+=**/.git/**
set wildignorecase

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

set tabstop=4

set shiftwidth=4
set expandtab
autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -T5pb

set backspace=2

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-N> :tabn<CR>
nnoremap <C-P> :tabp<CR>
nnoremap <C-T> :tabnew<CR>


vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> D       DVB_Duplicate()
let g:DVB_TrimWS = 1

set tabpagemax=24

set splitbelow
set splitright

au BufNewFile,BufRead *.ms set filetype=groff

set number relativenumber
set ruler

set ic incsearch
set smartcase

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

exec "set listchars=tab:\uBB\uBB,nbsp:~,trail:\uB7"
set list

execute pathogen#infect()
call pathogen#helptags()

"map ; :Files<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-g> :Ag<CR>

nnoremap <silent> <Leader>c :setlocal spell!<CR>

set showcmd


autocmd BufRead,BufNewFile *.h set filetype=c

let g:ale_c_parse_makefile = 1

"autocmd FileType groff inoremap <buffer> <Space><Space> <Esc>/<++><CR>c4l
autocmd FileType groff nnoremap <buffer> <F2> :w<CR>:call job_start(['/bin/sh', '-c', "groff -R -t -p -e -k -ms -Tps <C-R>% \| ps2pdf - ".expand('%:r').".pdf"])<CR><CR>
autocmd FileType groff inoremap <buffer> <F2> <Esc><F2>

autocmd FileType markdown nnoremap <buffer> <F2> :w<CR>:call job_start(['/bin/sh', '-c', "pandoc --pdf-engine=xelatex -tpdf <C-R>% > .".expand('%:r').".pdf && mv .".expand('%:r').".pdf ".expand('%:r').".pdf"])<CR>
autocmd FileType markdown inoremap <buffer> <F2> <Esc><F2>


"autocmd FileType html,tex,python,c,perl,js,php,java,make,cmake inoremap <buffer> <Space><Space> <Esc>/<++><CR>c4l


let g:tex_flavor = "latex"

" Compile latex documents asynchronously with Vimtex
autocmd FileType tex nnoremap <buffer> <F2> :w<CR>:VimtexCompile<CR>
autocmd FileType tex nnoremap <buffer> <F3> :w<CR>:VimtexClean<CR>
autocmd FileType tex inoremap <buffer> <F2> <Esc><F2>

autocmd FileType rmd nnoremap <buffer> <F2> :w<CR>:RMarkdown pdf<CR>

" Agda-vim
au BufNewFile,BufRead *.agda setlocal filetype=agda

augroup VimCompletesMeTex
    autocmd!
    autocmd FileType tex
        \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete
augroup END

augroup vimtex_config
  autocmd!
  autocmd User VimtexQuit call vimtex#latexmk#clean(0)
augroup END

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-interaction=nonstopmode',
    \ ],
    \ 'build_dir' : 'build'
    \}

let g:ale_pattern_options = {
\   '.*\.tex$': {'ale_enabled': 0},
\}

let g:ale_linters = {
            \ 'c': ['gcc', 'clangtidy'],
            \ 'haskell': ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc'],
            \}

xmap <silent><expr>  ++  VMATH_YankAndAnalyse()
nmap <silent>        ++  vip++

nnoremap <Left> <nop>
nnoremap <Up> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>

colorscheme ron

" Common Abbreviations

ab hte the
ab teh the
