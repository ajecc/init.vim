" plugins
filetype plugin indent on   
call plug#begin('~/.vim/plugged')
    " theme 
    Plug 'morhetz/gruvbox'

    " autocomplete related
    Plug 'ycm-core/YouCompleteMe'

    " exploring
    Plug 'preservim/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'zefei/vim-wintabs'
    Plug 'kien/tabman.vim'
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'

    " editing convinience
    Plug 'dominikduda/vim_current_word'
    Plug 'jiangmiao/auto-pairs'

    " python specific 
    Plug 'vim-python/python-syntax'
    Plug 'vim-syntastic/syntastic' 
    Plug 'davidhalter/jedi-vim'
    Plug 'nvie/vim-flake8'
call plug#end()            


" autocomplete
let g:ycm_auto_trigger = 1
let g:ycm_max_num_candidates = 10
set completeopt-=preview
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signature_delay = 0


" aspect
colorscheme gruvbox
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_delay = 500
hi! CurrentWordTwins cterm=NONE ctermfg=NONE ctermbg=238


" navigations
set splitright
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>
map <C-L> <C-W><C-L>
map <C-H> <C-W><C-H>
map <silent> <C-n> :NERDTreeTabsToggle<CR>
map <silent> <C-m> :TMFocus<CR>
map <silent> gt :YcmCompleter GoTo<CR>
map <silent> <C-c> :WintabsClose<CR>
map <silent> <C-e> :WintabsPrevious<CR>
map <silent> <C-r> :WintabsNext<CR>
let g:wintabs_display = 'statusline'
command Q q
command W w
command WQ wq
command Wq wq
command WA wa
command Wa wa
command WQA wqa
command WQa wqa
command WqA wqa
command Wqa wqa

function! SessionAutosave()
    if filereadable(".session.vim")
        let g:session_autosave = 'yes'
    else
        let g:session_autosave = 'no'
    endif
endfun

set sessionoptions-=options  " Don't save options
let g:session_directory = getcwd() 
let g:session_lock_enabled = 0
let g:session_default_name = '.session'
let g:session_autoload = 'yes'
autocmd VimEnter * call SessionAutosave()


" folding, spacing etc
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=utf-8
autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99


" python specific 
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E501,E302,E261,E262,E701,E241,E126,E127,E128,E722,W801,W391,W291,F401,F811'

function GruvboxHighlights()
    hi! link pythonFunctionCall GruvboxAqua 
endfunction
autocmd FileType python call GruvboxHighlights()


" various functions
function! InitProject_()
    execute 'SaveSession'
endfun
command InitProject call InitProject_() 
