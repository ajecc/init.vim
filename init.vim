" PLUGINS
filetype plugin indent on   
call plug#begin('~/.vim/plugged')
    " theme 
    Plug 'morhetz/gruvbox'
    " autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 
    " exploring
    Plug 'preservim/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'zefei/vim-wintabs'
    Plug 'kien/tabman.vim'
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'
    " editing convinience
    Plug 'dominikduda/vim_current_word'
    Plug 'tmsvg/pear-tree'
    Plug 'psliwka/vim-smoothie'
    " python specific 
    Plug 'vim-python/python-syntax'
    " webdev specific
    Plug 'pangloss/vim-javascript'
    Plug 'ap/vim-css-color'
    " linting
    Plug 'vim-syntastic/syntastic' 
call plug#end()            

" COC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_global_extension = [
            \'coc-tsserver',
            \'coc-prettier',
            \'coc-json',
            \'coc-python'
            \'coc-html',
            \'coc-angular',
            \'coc-ccls'
            \]
let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }

" ASPECT
colorscheme gruvbox
function GruvboxHighlights()
    hi! link pythonFunctionCall GruvboxAqua 
endfunction
autocmd FileType python call GruvboxHighlights()
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_delay = 500
hi! CurrentWordTwins cterm=NONE ctermfg=NONE ctermbg=238

" NAVIGATIONS
set splitright
nmap <C-l> <C-W><C-L>
nmap <C-h> <C-W><C-H>
map <silent> <C-n> :NERDTreeTabsToggle<CR>
map <silent> <C-m> :TMFocus<CR>
" coc symbol util
    " GoTo code navigation.
nmap <silent> gt <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
    " Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" wintabs
nmap <leader>rn <Plug>(coc-rename)
map <silent> <C-c> :WintabsClose<CR>
map <silent> <C-d> :WintabsPrevious<CR>
map <silent> <C-f> :WintabsNext<CR>
let g:wintabs_display = 'statusline'
" tabman
unmap <Enter>
" smoothie (scroll)
let g:smoothie_no_default_mappings = 1
silent! nmap <unique> <C-j> <Plug>(SmoothieDownwards)
silent! nmap <unique> <C-k> <Plug>(SmoothieUpwards)
" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_map_special_keys = 0
imap <BS> <Plug>(PearTreeBackspace)
imap <CR> <Plug>(PearTreeExpand)
" oopsies
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

" SESSION
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

" FOLDING, SPACING ETC
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=utf-8
autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "script,address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"

" SYNTASTIC 
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E501,E302,E261,E262,E701,E241,E126,E127,E128,E722,W801,W391,W291,F401,F811'
let g:syntastic_html_checkers = ['tidy']
if !exists('g:syntastic_html_tidy_ignore_errors')
    let g:syntastic_html_tidy_ignore_errors = []
endif
let g:syntastic_html_tidy_ignore_errors = ['ng-', 'mat-']

" VARIOUS FUNCTIONS
function! InitProject_()
    execute 'SaveSession'
endfun
command InitProject call InitProject_() 

" TERMINAL
set guicursor=n:block-blinkwait700-blinkon400-blinkoff250
set guicursor=i:ver25-blinkon0
au VimLeave * set guicursor=a:ver25-blinkon0
au VimLeave * !color
