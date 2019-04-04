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
call vundle#end()

filetype plugin indent on

set tabstop=4

set shiftwidth=4
set expandtab
autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -T5pb

set backspace=2

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

call plug#begin('~/.vim/plugged')
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
call plug#end()

set number! relativenumber!
set ruler

set ic incsearch

execute pathogen#infect()
call pathogen#helptags()
map <Leader>o :NERDTreeToggle<CR>

map ; :Files<CR>

noremap <F3> :Autoformat<CR>:w<CR>

set showcmd

autocmd FileType java nnoremap <F2> :w<CR>:VimuxRunCommand "mvn clean test install"<CR>
autocmd FileType java nnoremap <F4> :w<CR>:VimuxRunCommand "mvn clean"<CR>
autocmd FileType java nnoremap <F5> :w<CR>:VimuxRunCommand "mvn clean test install; java -jar target/*.jar; mvn clean"<CR>


autocmd FileType html,tex,python,c,perl,js,php,java inoremap <Space><Space> <Esc>/<++><CR>c4l

autocmd FileType html,php inoremap ;html <Esc>:read ~/dotfiles/skeleton.html<CR>kddi
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

autocmd FileType tex inoremap ;tex <Esc>:read ~/dotfiles/skeleton.tex<CR>i
autocmd FileType tex inoremap ;sec \section{<++>}<CR><++><Esc>kI<Space><Space>
autocmd FileType tex inoremap ;ssec \subsection{<++>}<CR><++><Esc>kI<Space><Space>
autocmd FileType tex inoremap ;sssec \subsubsection{<++>}<CR><++><Esc>kI<Space><Space>
autocmd FileType tex inoremap ;img \includegraphics[<++>]{<++>}<Esc>I<Space><Space>
autocmd FileType tex inoremap ;ctr \centering{<++>}<CR><++><Esc>kI<Space><Space>
autocmd FileType tex inoremap ;bfs \bfseries{<++>}<++>I<Space><Space>
autocmd FileType tex inoremap ;ref \ref{<++>}<++>I<Space><Space>
autocmd FileType tex inoremap ;cite \cite{<++>}<++>I<Space><Space>

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
