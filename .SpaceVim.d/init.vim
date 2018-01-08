" Configuration by Kamontat Chantrachirathumrong
" Theme: onedark
" Date: 17 Nov 2560

" Dark powered mode of SpaceVim
let g:spacevim_automatic_update = 1
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1

" ####################################
" language support 
" ####################################
" call SpaceVim#layers#load('lang#go')
" call SpaceVim#layers#load('lang#java')
call SpaceVim#layers#load('lang#javascript')
call SpaceVim#layers#load('lang#typescript')
call SpaceVim#layers#load('lang#json')
call SpaceVim#layers#load('lang#sh')
" call SpaceVim#layers#load('lang#php')
call SpaceVim#layers#load('lang#python')
" call SpaceVim#layers#load('lang#tmux')
call SpaceVim#layers#load('lang#vim')
" call SpaceVim#layers#load('lang#xml')
call SpaceVim#layers#load('lang#ruby')
call SpaceVim#layers#load('lang#markdown')

" ####################################
" layer support 
" ####################################
call SpaceVim#layers#load('incsearch')
call SpaceVim#layers#load('shell', 
    \ {
    \ 'default_position' : 'bottom',
    \ 'default_height' : 30,
    \ }
    \ )
call SpaceVim#layers#load('vim')
call SpaceVim#layers#load('tools#screensaver')
call SpaceVim#layers#load('autocomplete')

" ####################################
" default setting
" ####################################

" types:
" 0: 1 ➛ ➊
" 1: 1 ➛ ➀
" 2: 1 ➛ ⓵
" 3: 1 ➛ ¹
" 4: 1 ➛ 1
let g:spacevim_buffer_index_type = 1
let g:spacevim_windows_index_type = 2
let g:spacevim_enable_statusline_display_mode = 1
let g:spacevim_enable_cursorcolumn = 1
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_enable_googlesuggest = 1

let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_enable_vimfiler_gitstatus = 1
let g:spacevim_enable_vimfiler_filetypeicon = 1
let g:vimfiler_quick_look_command = "vim"

" ####################################
" Custom key map 
" ####################################
let g:spacevim_unite_leader = 'U'                              
let g:spacevim_denite_leader = 's'                           

" ####################################
" Custom Plugin
" ####################################

let g:spacevim_custom_plugins = [
\ ['wakatime/vim-wakatime'],
\ ['junegunn/vim-github-dashboard'],
\ ]

" ####################################
" " SpaceVim theme
" ####################################
let g:spacevim_statusline_separator = 'slant'
let g:spacevim_colorscheme = 'onedark'
let g:spacevim_colorscheme_bg = 'dark'

let g:spacevim_guifont = 'FuraCode\ Nerd\ Font\ Mono\ 16'

" ####################################
" SpaceVim Language 
" ####################################
" let g:spacevim_vim_help_language = 'cn'
" let g:spacevim_language = 'en_CA.utf8'

" ####################################
" SpaceVim code
" ####################################
let g:spacevim_default_indent = 4
let g:spacevim_github_username = "kamontat"
let g:spacevim_lint_on_save = 1

" ####################################
" misc
" ####################################
let g:neomake_vim_enabled_makers = []

let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 150
" let g:deoplete#max_list = 5

if executable('vimlint')
    call add(g:neomake_vim_enabled_makers, 'vimlint') 
endif
if executable('vint')
    call add(g:neomake_vim_enabled_makers, 'vint') 
endif
if has('python3')
    let g:ctrlp_map = ''
    nnoremap <silent> <C-p> :Denite file_rec<CR>
endif

let g:clang2_placeholder_next = ''
let g:clang2_placeholder_prev = ''

" ####################################
" Vim setting
" ####################################

set clipboard=unnamed       " <C-c> | y is the same clipboard
set completefunc=emoji#complete

" ####################################
" Custom keyblind
" ####################################
" for emoji
" imap <TAB> <C-x><C-u> 
command Emoji :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" let g:startify_custom_header
" let g:tinyline_max_dirs = 3
