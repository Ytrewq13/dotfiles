" TODO: organise this file

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'jvenant/vim-java-imports'
Plugin 'ap/vim-css-color'
Plugin 'janko/vim-test'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dense-analysis/ale'
Plugin 'wesQ3/vim-windowswap'
Plugin 'lervag/vimtex'
call vundle#end()

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
"nnoremap <C-S-Y> :tabnew " TODO: find an unused key combination or pick a key
"sequence for opening new files in tabs.

set tabpagemax=24

set splitbelow
set splitright

au BufNewFile,BufRead *.ms set filetype=groff

set number! relativenumber!
set ruler

set ic incsearch

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

exec "set listchars=tab:\uBB\uBB,nbsp:~,trail:\uB7"
set list

execute pathogen#infect()
call pathogen#helptags()
map <Leader>o :NERDTreeToggle<CR>

map ; :Files<CR>

noremap <F3> :Autoformat<CR>:w<CR>

nnoremap <silent> <Leader>c :setlocal spell!<CR>

set showcmd

"let g:ale_linters = {'haskell': ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc']}

autocmd BufRead,BufNewFile *.h set filetype=c

let g:ale_c_parse_makefile = 1

autocmd FileType java nnoremap <F2> :w<CR>:Java<CR>
autocmd FileType java nnoremap <F4> :w<CR>:VimuxRunCommand "mvn clean"<CR>
autocmd FileType java nnoremap <F5> :w<CR>:VimuxRunCommand "mvn clean test install; java -jar target/*.jar; mvn clean"<CR>

autocmd FileType groff inoremap <Space><Space> <Esc>/<++><CR>c4l
autocmd FileType groff nnoremap <F2> :w<CR>:call job_start(['/bin/sh', '-c', "groff -R -t -p -e -k -ms -Tps <C-R>% \| ps2pdf - ".expand('%:r').".pdf"])<CR><CR>
autocmd FileType groff inoremap <F2> <Esc><F2>
autocmd FileType groff inoremap ;ms <Esc>:-1read ~/dotfiles/skeleton.ms<CR>ggi<Space><Space>

" TODO: use job_start instead of VimuxRunCommand for all relevant bindings
autocmd FileType markdown nnoremap <F2> :w<CR>:call job_start(['/bin/sh', '-c', "pandoc --pdf-engine=xelatex -tpdf <C-R>% > .".expand('%:r').".pdf && mv .".expand('%:r').".pdf ".expand('%:r').".pdf"])<CR>
autocmd FileType markdown imap <F2> <Esc><F2>

autocmd FileType c,cpp nnoremap <F2> :w<CR>:VimuxRunCommand "make"<CR>
autocmd FileType c,cpp inoremap <F2> <Esc>:w<CR>:VimuxRunCommand "make"<CR>
autocmd FileType c,cpp nnoremap <F3> :w<CR>:VimuxRunCommand "make clean"<CR>
autocmd FileType c,cpp inoremap <F3> <Esc>:w<CR>:VimuxRunCommand "make clean"<CR>
autocmd FileType c,cpp noremap <F4> :Autoformat<CR>:w<CR>


autocmd FileType html,tex,python,c,perl,js,php,java inoremap <Space><Space> <Esc>/<++><CR>c4l

autocmd FileType html,php inoremap ;html <Esc>:-1read ~/dotfiles/skeleton.html<CR>kddi
autocmd FileType html,php inoremap ;p <p><CR><++><CR></p><CR><++><Esc>3k^/<++><CR>c4l<Tab>
autocmd FileType html,php inoremap ;div <div><CR><++><CR></div><CR><++><Esc>3k^/<++><CR>c4l<Tab>
autocmd FileType html,php inoremap ;span <span><CR><++><CR></span><CR><++><Esc>3k^/<++><CR>c4l<Tab>
autocmd FileType html,php inoremap ;h1 <h1><++></h1><++><Esc>^/<++><CR>c4l
autocmd FileType html,php inoremap ;h2 <h2><++></h2><++><Esc>^/<++><CR>c4l
autocmd FileType html,php inoremap ;h3 <h3><++></h3><++><Esc>^/<++><CR>c4l
autocmd FileType html,php inoremap ;img <img src='<++>'><++></img><++><Esc>^/<++><CR>c4l
autocmd FileType html,php inoremap ;a <a href='<++>'><++></a><++><Esc>^/<++><CR>c4l
autocmd FileType html,php inoremap ;ul <CR><ul><CR><++><CR></ul><++><Esc>3k^/<++><CR>c4l
autocmd FileType html,php inoremap ;li <li><++></li><++><Esc>^/<++><CR>c4l

let g:tex_flavor = "latex"

" autocmd FileType tex nnoremap <F2> :w<CR>:call job_start(['/bin/sh', '-c', "latexmk -pdfxe -quiet " . bufname("%") . ";latexmk -c -quiet " . bufname("%")])<CR><CR>
autocmd FileType tex nnoremap <F2> :w<CR>:call VimuxRunCommand("latexmk -pdfxe -quiet " . bufname("%") . ";latexmk -c -quiet " . bufname("%"))<CR><CR>
autocmd FileType tex inoremap <F2> <Esc><F2>

augroup VimCompletesMeTex
    autocmd!
    autocmd FileType tex
        \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete
  augroup END

let g:ale_pattern_options = {
\   '.*\.tex$': {'ale_enabled': 0},
\}

let g:ale_linters = {
            \ 'c': ['gcc', 'clangtidy'],
            \}

autocmd FileType python inoremap ;f def <++>(<++>):<CR><++><Esc>k15hi

autocmd FileType c inoremap ;f <++> <++>(<++>)<CR>{<CR><++><CR>}<++><Esc>3k15hi
autocmd FileType c inoremap ;main int main(int argc, char **argv)<CR>{<CR><++><CR>return 0;<CR>}<Esc>2kI<Space><Space>
autocmd FileType c inoremap ;for int i;<CR>for (i = 0; i < <++>; i++)<CR>{<CR><++><CR>}<CR><++><Esc>4kI<Space><Space>

autocmd FileType java inoremap ;main public static void main(String[] args)<CR>{<CR><++><CR>}<Esc>kI<Space><Space>
autocmd FileType java inoremap ;pub public <++> <++>(<++>)<CR>{<CR><++><CR>}<CR><++><Esc>4k22hi
autocmd FileType java inoremap ;priv private <++> <++>(<++>)<CR>{<CR><++><CR>}<CR><++><Esc>4k23hi
autocmd FileType java inoremap ;for for (int i = 0; i < <++>; i++)<CR>{<CR><++><CR>}<Esc>3kI<Space><Space>

autocmd FileType java,c inoremap ;while while (<++>)<CR>{<CR><++><CR>}<Esc>3kI<Space><Space>

nnoremap <Left> <nop>
vnoremap <Left> <nop>
nnoremap <Up> <nop>
vnoremap <Up> <nop>
nnoremap <Right> <nop>
vnoremap <Right> <nop>
nnoremap <Down> <nop>
vnoremap <Down> <nop>

colorscheme ron
