set autowriteall

set wrap

set textwidth=0

set wrapmargin=0

set linebreak

set splitbelow

set mouse=v "middle click paste

set hlsearch "highlight search

set tabstop=4 "number of columns in search

set softtabstop=4 "multiple spaces = tab for backspace

set shiftwidth=4 "autoindent width

set autoindent "indent new lines

set number "line numbers

syntax on

set mouse=a "enable mouse click

set clipboard+=unnamedplus "use system clipboard

"set cursorline "cursor line

set ttyfast "faster scrolling

set spell "spell check

set backupdir=~/.cache/vim

set noswapfile "doesn't store swap file

set wildmode=longest,list,full "enable autocomplete

set nocompatible
filetype plugin on

"disable auto commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"replace all is aliased to S
nnoremap S :%s//g<Left><Left>

"save files as sudo that require root
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"automatically delete all trailing whitespace and new lines at end of file
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

let g:tex_flavor = 'latex'
let g:tex_conceal = ''
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:languagetool_jar='~/LanguageTool-5.2/languagetool-commandline.jar'

call plug#begin("~/.vim/plugged")

" plugin section

Plug 'kristijanhusak/vim-hybrid-material'

let g:airline_theme='hybrid'

" if (exists("termguicolors"))
"	set termguicolors
" endif


" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'


let g:limelight_bop = '^.*$'
let g:limelight_eop = '\n'
let g:limelight_paragraph_span = 0

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1



Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'dpelle/vim-LanguageTool'
Plug 'junegunn/limelight.vim'

call plug#end()

colorscheme hybrid_material

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE


nnoremap j gj
nnoremap k gk

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_CompileRule_pdf = 'mkdir -p build && pdflatex -output-directory=build -interaction=nonstopmode $* && mv build/$*.pdf .'
let g:Tex_GotoError = 0
let g:Tex_ViewRule_pdf = 'zathura'
if has('gui_running')
  set grepprg=grep\ -nH\ $*
  filetype indent on
  let g:tex_flavor='latex'
endif

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

augroup Goyo | au! User GoyoEnter call <SID>goyo_enter() | Limelight | augroup END

augroup Goyo! | au! User GoyoLeave call <SID>goyo_leave() | Limelight! | augroup END
