set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set runtimepath+=~/.vim/
set backupdir=~/.vim/backup

"-----------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'w0rp/ale'

Plug 'chriskempson/base16-vim'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

" auto completion
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'
Plug 'osyo-manga/vim-marching'
"Plug 'the-lambda-church/merlin' "ocaml
Plug 'octol/vim-cpp-enhanced-highlight'

" display color rgb/hex
Plug 'lilydjwg/colorizer'

" powerbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
let base16colorspace=256
colorscheme base16-bright

filetype plugin indent on

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.9/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.9/'

" enable syntax highlighting
syntax on

" highlight searched terms
set hlsearch

" automatically indent on next line
set smartindent

" show line numbers
set nu

" enable mouse
set mouse=a

" allow backspace
set backspace=indent,eol,start

" break lines before col 80, between words
set lbr
set colorcolumn=80


" allow folding by indentation
set foldmethod=indent


set wildmenu

" enable syntax highlighting
" highlight searched terms
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" tab width 2; use spaces only
set sts=2 " soft tab stop of length 2
set ts=2 " display tab stop length of 2
set sw=2 " shift width of 2
set et " expand tab
set sta " smart tab

" Strip trailing whitespace
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.h   :%s/\s\+$//e
autocmd BufWritePre *.tex   :%s/\s\+$//e
autocmd BufWritePre *.py   :%s/\s\+$//e

" open NERDTree automatically in starts up
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

"-----------------------------------------------------------------------
" Ocaml setup
"-----------------------------------------------------------------------

" merlin
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

" ocp-indent
"set rtp^="/home/jskd/.opam/4.02.3/share/ocp-indent/vim"

"-----------------------------------------------------------------------
" Multiple cursors
"-----------------------------------------------------------------------

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Map start key separately from next key
let g:multi_cursor_start_key='<F6>'

let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

"-----------------------------------------------------------------------
" Clang
"-----------------------------------------------------------------------

let g:clang_library_path='/usr/lib/llvm-3.8/lib'
let g:clang_user_options = '-I/usr/include/ -I/usr/include/c++/4.9/'

"-----------------------------------------------------------------------
" Marching
"-----------------------------------------------------------------------

let g:marching_clang_command = 'usr/bin/clang'
let g:marching#clang_command#options = {
\   'cpp': '-std=c++11',
\ }

let g:marching_include_paths = [
\   '/usr/include/',
\   '/usr/include/SFML/',
\   '/usr/include/c++/4.9/'
\ ]

if filereadable('./.includes_list')
  let g:marching_include_paths += readfile('./.includes_list')
endif

let g:marching_enable_neocomplete = 1

set updatetime=200

"-----------------------------------------------------------------------
" Snippet
"-----------------------------------------------------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"-----------------------------------------------------------------------
" Neocomplete
"-----------------------------------------------------------------------

" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"  \ <SID>check_back_space() ? "\<TAB>" :
"  \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Auto close the preview window
let g:neocomplete#enable_auto_close_preview = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Marching enable
let g:marching_enable_neocomplete = 1

" Enable heavy omni completion
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" force partterns
"if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"endif
let g:neocomplete#force_omni_input_patterns.c=
  \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
  \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.ocaml =
  \ '[^. *\t]\.\w*\|\h\w*|#'
let g:neocomplete#force_omni_input_patterns.python =
  \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.php =
  \ '[^. \t]->\h\w*\|\h\w*::'


" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = "arm-none-eabi-g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:cssColorVimDoNotMessMyUpdatetime = 1
let g:syntastic_cpp_config_file = './.include'


let g:syntastic_c_compiler = 'arm-none-eabi-gcc'
let g:syntastic_c_generic = 1

let g:syntastic_asm_compiler = 'arm-none-eabi-gcc'
let g:syntastic_asm_generic = 1

nmap <F8> :TagbarToggle<CR>

syntax enable

" syntastic cpp
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_include_dirs = ["includes", "headers", "inc"]
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol=''
let g:syntastic_style_error_symbol='⚑'
let g:syntastic_warning_symbol=''
let g:syntastic_style_warning_symbol='⚐'


" ALE config
let g:ale_echo_msg_error_str= ' '
let g:ale_echo_msg_warning_str= ' '
let g:ale_sign_error= ' '
let g:ale_sign_warning= ' '
let g:ale_sign_column_always = 1
let g:ale_c_clang_options = '-std=c11 -Wall -Wextra'


highlight Search term=reverse ctermfg=0 ctermbg=3

"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
"highlight link SyntasticStyleErrorSign SignColumn
"highlight link SyntasticStyleWarningSign SignColumn

"highlight SyntasticErrorSign ctermfg=white ctermbg=red
"highlight SyntasticWarningSign ctermfg=white ctermbg=blue
"highlight SyntasticStyleErrorSign ctermfg=white ctermbg=yellow
"highlight SyntasticStyleWarningSign ctermfg=white ctermbg=blue

" Indentation color
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

"let g:airline_theme='tomorrow'
let g:airline_powerline_fonts=1


let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" unicode symbols
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_section_z = airline#section#create(['windowswap', "\uE0A1".'%l/%L' . " " . "\uE0A3" . '%v'])

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('c', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('cpp', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('h', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('hpp', 'Magenta', 'none', '#ff00ff', '#151515')

let g:NERDTreeShowIgnoredStatus = 1

let g:NERDTreeMapNextHunk = "c"
let g:NERDTreeMapPrevHunk = "c"

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : " ",
  \ "Staged"    : " ",
  \ "Untracked" : " ",
  \ "Renamed"   : " ",
  \ "Unmerged"  : " ",
  \ "Deleted"   : " ",
  \ "Dirty"     : " ",
  \ "Clean"     : " ",
  \ 'Ignored'   : " ",
  \ "Unknown"   : " "
\ }

autocmd BufNewFile,BufReadPost *.c,*.h,*.cpp,*.hpp call SetCOptions()
function! SetCOptions()
  :retab
  :call tagbar#autoopen(0)
  let g:indent_guides_guide_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_enable_on_vim_startup = 1
  :IndentGuidesEnable
endfunction


"------------------------------------------------------------------------------
" vim-cpp-enhanced-highlight
"------------------------------------------------------------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1

"------------------------------------------------------------------------------
" date
"------------------------------------------------------------------------------
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

:inoremap <F2>  * @author Jérôme SKODA <contact@jeromeskoda.fr>
:tnoremap <Esc> <C-\><C-n>


:map - <C-W>-
:map + <C-W>+
:map <M-<> <C-W><
:map <M->> <C-W>>



let g:jedi#force_py_version = 3
