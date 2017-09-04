" Initialize vim-plug

call plug#begin()
" Nerdtree and Nerdcommenter
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'

" Airline (Status Line)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugs for tmux
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'

" Tpope's awesome plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

Plug 'lilydjwg/colorizer'
Plug 'Galooshi/vim-import-js'
Plug 'ElmCast/elm-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'neovim/node-host'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/snipmate-snippets'
Plug 'shaunlebron/parinfer'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/mru.vim'
Plug 'w0rp/ale'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'airblade/vim-gitgutter'
Plug 'amix/vim-zenroom2'
Plug 'digitaltoad/vim-pug'
Plug 'fatih/vim-go'
Plug 'garbas/vim-snipmate'
Plug 'git://git.wincent.com/command-t.git'
Plug 'groenewege/vim-less'
Plug 'honza/vim-snippets'
Plug 'jackiehluo/vim-material'
Plug 'jdkanani/vim-material-theme'
Plug 'kchmck/vim-coffee-script'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nvie/vim-flake8'
Plug 'plasticboy/vim-markdown'
Plug 'rakr/vim-one'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'shemerey/vim-peepopen'
Plug 'sophacles/vim-bundle-mako'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'

" searching plug
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" WakaTime Time Tracker
Plug 'wakatime/vim-wakatime'

call plug#end()

filetype plugin indent on

" Vim JSX
let g:jsx_ext_required = 0

" YCM
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'

" Airline (themes: onedark powerlineish base16_spacemacs minimalist angr base16 luna)
let g:airline_powerline_fonts=1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled=1

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-P> <Plug>yankstack_substitute_newer_paste

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=25

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>d :GitGutterToggle<cr>
let g:gitgutter_enabled=0

let g:polyglot_disabled = ['elm', 'javascript', 'jsx']

" vim easymotion
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" line too
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

" Implement basic search
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
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion()) 
