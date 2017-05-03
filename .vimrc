" Setting up Vundle - the vim plugin bundler
let isInstall=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme) 
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
	isInstall=0
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"*********************************************************************"
" Example adding format
"*********************************************************************"
"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
"" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"*********************************************************************"
" Add customize plugin
"*********************************************************************"

Plugin 'bling/vim-bufferline'					" show list of buffer in command bar  -- https://github.com/bling/vim-bufferline
Plugin 'mildred/vim-bufmru'                     " buffer switch                       -- https://github.com/mildred/vim-bufmru
" line plugin
Plugin 'vim-airline/vim-airline'				" tabbar/bottombar custom             -- https://github.com/vim-airline/vim-airline
Plugin 'edkolev/tmuxline.vim'                   " other bottombar                     -- https://github.com/edkolev/tmuxline.vim
Plugin 'edkolev/promptline.vim'                 " other cmdline                       -- https://github.com/edkolev/promptline.vim
" theme plugin
Plugin 'vim-airline/vim-airline-themes'			" theme of tabbar/bottombar           -- https://github.com/vim-airline/vim-airline-themes
Plugin 'altercation/vim-colors-solarized'		" solarized syntax theme              -- https://github.com/altercation/vim-colors-solarized
" coding
Plugin 'vim-syntastic/syntastic'                " syntax checking                     -- https://github.com/vim-syntastic/syntastic
" html plugin
Plugin 'jiangmiao/auto-pairs'					" auto insert },>,)                   -- https://github.com/jiangmiao/auto-pairs
Plugin 'alvan/vim-closetag'						" auto close http tag                 -- https://github.com/alvan/vim-closetag
Plugin 'mattn/emmet-vim'						" improves HTML & CSS workflow        -- https://github.com/mattn/emmet-vim
" git workflow 
Plugin 'jreybert/vimagit'                       " git workflow                        -- https://github.com/jreybert/vimagit
Plugin 'airblade/vim-gitgutter'					" git diff and reverse                -- https://github.com/airblade/vim-gitgutter
" searching plugin
Plugin 'easymotion/vim-easymotion'              " improves motion of the vim editor   -- https://github.com/easymotion/vim-easymotion
Plugin 'haya14busa/incsearch.vim'				" improves basic search `/`, `?`      -- https://github.com/haya14busa/incsearch.vim
Plugin 'haya14busa/incsearch-fuzzy.vim'         " ------------------------------      -- https://github.com/haya14busa/incsearch-fuzzy.vim
Plugin 'haya14busa/incsearch-easymotion.vim'    " ------------------------------      -- https://github.com/haya14busa/incsearch-easymotion.vim


"*********************************************************************"
" End adding plugin
"*********************************************************************"
if isInstall == 0
	echo "Installing Bundle, Please ignore error message"
	:PluginInstall
endif
call vundle#end()            " required
filetype plugin indent on    " required
" :PluginInstall

"*********************************************************************"
" Vundle Helper
"*********************************************************************"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"*********************************************************************"
" Basic setting
"*********************************************************************"
" syntax color 
syntax enable
let g:solarized_termcolors=256
let g:solarized_contrast="high"
" default background
set background=dark
" airline theme
let g:airline_theme='dark' " wombat, light, badwolf, molokai
colorscheme solarized

" Customize syntax
highlight! Normal ctermfg=green cterm=NONE
highlight! LineNr ctermfg=white cterm=NONE

set tabstop=4            " tab size
" set backspace=2          " set backspace bug
set backspace=indent,eol,start
set expandtab          " use `space` instead of `tab`
set shiftwidth=4         " tab when >> occurred
set number               " show line number
set smartindent
set autoindent
set softtabstop=4
set shell=/bin/bash
let mapleader=" "          " set lender key
" set list lcs=tab:\|\       " (here is a space)
" set list lcs+=space:·      " set . instead space

"*********************************************************************"
"" Plugin Setting
"*********************************************************************"

" syntastic setting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1 
" java syle
let g:syntastic_java_checkers = ['checkstyle'] " set checker for java language
let g:syntastic_java_checkstyle_classpath = '~/.vim/checker/checkstyle-7.7-all.jar'
let g:syntastic_java_checkstyle_conf_file = '~/.vim/checker/sum_checks.xml'
" javascript stype
let g:syntastic_javascript_checkers = ['jshint']

" vim airline
let g:airline#extensions#tabline#enabled=2
set laststatus=2
let g:airline_powerline_fonts = 1                     " enable icon
let g:airline#extensions#branch#enabled = 1           " enable branch of git 
let g:airline#extensions#bufferline#enabled = 0       " enable bufferline
let g:airline#extensions#syntastic#enabled = 1        " enable syntastic
let g:airline#extensions#vimagit#enabled = 1          " enable vimagit

" tmux line
" let g:tmuxline_preset = 'full'                      " full detail
let g:tmuxline_preset = {
      \     'a'    : '#S',
      \     'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
      \     'win'  : '#I #W',
      \     'cwin' : '#I #W #F',
      \     'x'    : '#(date +"%A %d %B %Y (%X)")',
      \     'z'    : '#h'
      \ }
" change color on different mode
" change status of Tmuxline when Vim mode changes
if exists('$TMUX')
function! AddTmuxlineStatus()
	if exists(':Tmuxline')
	augroup airline_tmuxline
		au!
		au InsertEnter * call SetInsert()
		au InsertChange * call SetInsert()
		autocmd InsertLeave * call SetNormal()
		vnoremap <silent> <expr> <SID>SetVisual SetVisual()
		nnoremap <silent> <script> v v<SID>SetVisual
		nnoremap <silent> <script> V V<SID>SetVisual
		nnoremap <silent> <script> <C-v> <C-v><SID>SetVisual
		autocmd CursorHold * call SetNormal()
	augroup END
	endif
endfunction
function! SetInsert()
	if v:insertmode == 'i'
		Tmuxline airline_insert
	else
		Tmuxline airline_replace
	endif
endfunction
function! SetVisual()
	set updatetime=0
	Tmuxline airline_visual
	return ''
endfunction
function! SetNormal()
	set updatetime=4000
	Tmuxline airline
endfunction
au VimEnter * :call AddTmuxlineStatus()
endif   " exists('$TMUX')

let g:airline#extensions#promptline#snapshot_file = "~/.shell_prompt.sh"

" git gutter
set updatetime=250 " set checking time around 350 ms
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" buffer switch
" imap <A-B> <Esc>:BufMRUPrev<CR>
" imap <A-b> <Esc>:BufMRUNext<CR>
" map <A-B>  :BufMRUPrev<CR>
map <leader>f  :BufMRUNext<CR>
map <leader>b  :BufMRUPrev<CR>
" map <Esc>B :BufMRUPrev<CR>
" map <Esc>b :BufMRUNext<CR>

" close tag (for web developer)
let g:closetag_filenames = "*.html,*.xhtml,*.phtml, *.xml, *.php"

" emmet setting
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-M>'       " C=ctrl, M=key `m`
silent autocmd FileType html,css EmmetInstall

" vim easymotion
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" implement basic search
function! s:incsearch_config(...) abort
	return incsearch#util#deepextend(deepcopy({
	  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
	  \   'keymap': {
	  \     "\<CR>": '<Over>(easymotion)'
	  \   },
	  \   'is_expr': 0
	  \ }), get(a:, 1, {}))
endfunction

function! s:config_easyfuzzymotion(...) abort
	return extend(copy({
	  \   'converters': [incsearch#config#fuzzyword#converter()],
	  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
	  \   'keymap': {
	  \	 	"\<CR>": '<Over>(easymotion)'
	  \	  },
	  \   'is_expr': 0,
	  \   'is_stay': 1
	  \ }), get(a:, 1, {}))
endfunction

" error occurred
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion()) 
