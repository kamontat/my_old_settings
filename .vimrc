" maintain: Kamontat Chantrachirathumrong
" version:  2.0.1
" since:    04/11/2017

source ~/.vim/basic.vim
source ~/.vim/filetype.vim
source ~/.vim/plugins.vim
source ~/.vim/extended.vim

set nocompatible

let g:enable_bold_font = 1

map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-U>
set nostartofline

noremap <up> <esc>:echoerr "Stop being stupid! Use k to go up."<cr><nop>
noremap <down> <esc>:echoerr "Stop being stupid! Use j to go down."<cr><nop>
noremap <left> <esc>:echoerr "Stop being stupid! Use h to go left."<cr><nop>
noremap <right> <esc>:echoerr "Stop being stupid! Use l to go right."<cr><nop>
inoremap <up> <esc>:echoerr "Stop being stupid! Use k to go up."<cr><nop>
vnoremap <up> <esc>:echoerr "Stop being stupid! Use k to go up."<cr><nop>
inoremap <down> <esc>:echoerr "Stop being stupid! Use j to go down."<cr><nop>
vnoremap <down> <esc>:echoerr "Stop being stupid! Use j to go down."<cr><nop>
inoremap <left> <esc>:echoerr "Stop being stupid! Use h to go left."<cr><nop>
vnoremap <right> <esc>:echoerr "Stop being stupid! Use l to go right."<cr><nop>
vnoremap <left> <esc>:echoerr "Stop being stupid! Use h to go left."<cr><nop>
inoremap <right> <esc>:echoerr "Stop being stupid! Use l to go right."<cr><nop>

nnoremap <CR> :noh<CR><CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

filetype plugin on
syntax enable

set number

set background=dark

set shiftwidth=2
set tabstop=2

" one
colorscheme wombat256i
