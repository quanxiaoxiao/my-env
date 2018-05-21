set number
set hlsearch
set cursorline
set cursorcolumn
set history=200
set nowrap

" map
nnoremap <leader>U viwU
nnoremap <leader>u viwu

" abbrev
iabbrev p@@ import PropTypes from 'prop-types';
iabbrev fp@@ import fp from 'lodash/fp';
iabbrev _@@ import _ from 'lodash';
iabbrev moment@@ import moment from 'moment';
iabbrev connect@@ import { connect } from 'react-redux';
iabbrev cn@@ import cn from 'classnames';
iabbrev toastr@@ import { toastr } from 'react-redux-toastr';
iabbrev request@@ import request from 'quan-request';
iabbrev payload@@ action.payload
iabbrev props@@ const {} = this.props;

iabbrev ps@@ PropTypes.string,
iabbrev pb@@ PropTypes.bool,
iabbrev po@@ PropTypes.object,
iabbrev pn@@ PropTypes.number,
iabbrev pa@@ PropTypes.array,
iabbrev pf@@ PropTypes.func,
iabbrev pe@@ PropTypes.element,

iabbrev paof@@ PropTypes.arrayOf(),
iabbrev pof@@ PropTypes.oneOf([]),
iabbrev poft@@ PropTypes.oneOfType([]),
iabbrev psh@@ PropTypes.shape({}),

iabbrev psr@@ PropTypes.string.isRequired,
iabbrev pbr@@ PropTypes.bool.isRequired,
iabbrev por@@ PropTypes.object.isRequired,
iabbrev pnr@@ PropTypes.number.isRequired,
iabbrev par@@ PropTypes.array.isRequired,
iabbrev pfr@@ PropTypes.func.isRequired,
iabbrev per@@ PropTypes.element.isRequired,

iabbrev paofr@@ PropTypes.arrayOf().isRequired,
iabbrev pofr@@ PropTypes.oneOf([]).isRequired,
iabbrev poftr@@ PropTypes.oneOfType([]).isRequired,
iabbrev pshr@@ PropTypes.shape({}).isRequired,

"autocommand
:autocmd BufRead .babelrc :set filetype=json
:autocmd BufRead .eslintrc :set filetype=json
:autocmd BufRead .eslintignore :set filetype=json

:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>


" -------------------------------------------------------------------->
" plugins
" execute pathogen#infect()
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
Plug 'https://github.com/stephenway/postcss.vim.git'
Plug 'https://github.com/danro/rename.vim.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/mxw/vim-jsx.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/benmills/vimux.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/ekalinin/Dockerfile.vim.git'
Plug 'https://github.com/mileszs/ack.vim.git'

call plug#end()


" -------------------------------------------------------------------->
syntax on
syntax enable
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=2
" 设置格式化时制表符占用空格数
set shiftwidth=2
" 自适应不同语言的智能缩进
" 让vim把连续数量的空格视为一个制表符
set softtabstop=2
filetype plugin indent on

" ident-guides
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guids_guide_size=1
:nmap <silent> <leader>i <Plug>IndentGuidesToggle

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.swp$', '\.git', '\.png$', '\.jpg$', 'node_modules']


let g:ctrlp_custom_ignore = {
\  'dir':  '\v[\/](node_modules|bower_components|dist)$',
\}


let g:ackprg = 'ag --nogroup --nocolor --column'

let g:jsx_ext_required=0

" theme
set background=dark
colorscheme gruvbox
" colorscheme molokai
" colorscheme dracula

" line

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1

function s:upperDashword(word)
  return toupper(substitute(a:word, '\([a-z]\+\)\([A-Z]\)', '\1_\2', 'g'))
endfunction

function s:convertReduxActionType()
  let a:word = expand('<cword>')
  let a:upperDashword = s:upperDashword(a:word)
  let a:path = matchlist(expand('%:t'), '\(.\+\)\.js$')[1]
  exe "norm! viwcexport const " .a:upperDashword. " = '" .a:path. "/" .a:upperDashword. "';\<Esc>"
endfunction

function s:generateReactState()
  let a:word = expand('<cword>')
  exe "norm! viwcconst { " .a:word. " } = this.state;"
endfunction

function s:generateReactProps()
  let a:word = expand('<cword>')
  exe "norm! viwcconst { " .a:word. " } = this.props;"
endfunction

function s:generateReduxAction()
  let a:word = expand('<cword>')
  let a:upperDashword = s:upperDashword(a:word)
  exe "norm! viwcexport const " .a:word. " = () =>
        \ ({\ntype:" a:upperDashword. ",\n});"
endfunction

function s:generateReduxDispatchAction()
  let a:word = expand('<cword>')
  let a:upperDashword = s:upperDashword(a:word)
  exe "norm! viwcexport const " .a:word. " = () =>\n(dispatch) => {\n};"
endfunction

nnoremap <leader>_ :<C-U>call <SID>convertReduxActionType()<CR> 
nnoremap <leader>a :<C-U>call <SID>generateReduxAction()<CR>
nnoremap <leader>d :<C-U>call <SID>generateReduxDispatchAction()<CR>
nnoremap <leader>s :<C-U>call <SID>generateReactState()<CR>
nnoremap <leader>p :<C-U>call <SID>generateReactProps()<CR>

"import require

function s:importModal()
  let a:word = expand('<cword>')
  let a:moduleName = tolower(a:word)
  exe "norm! ccimport " .a:word. " from '" .a:moduleName. "';"
endfunction

function s:requireModal()
  let a:word = expand('<cword>')
  let a:moduleName = tolower(a:word)
  exe "norm! ccconst " .a:word. " = require('" .a:moduleName. "');"
endfunction

nnoremap <leader>i :<C-U>call <SID>importModal()<CR>
nnoremap <leader>r :<C-U>call <SID>requireModal()<CR>


"Vimux

function s:installNodeModules()
  let a:line = getline('.')
  let a:matches = matchlist(a:line, '''\(\.\/\)\@!\([^'']\+\)'';')
  if !empty(a:matches)
    let a:name = get(a:matches, 2)
    echo a:name
    exe ":call VimuxRunCommand('clear; npm install " .a:name. "')"
  endif
endfunction

nnoremap <leader>nt :<C-U>call VimuxRunCommand('npm run test')<CR>
nnoremap <leader>nd :<C-U>call VimuxRunCommand('npm run dev')<CR>
nnoremap <leader>ni :<C-U>call <SID>installNodeModules()<CR>
