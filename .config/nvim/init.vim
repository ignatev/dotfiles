" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})
  call dein#add('stamblerre/gocode', {'rtp': 'nvim/'})
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

call dein#add('wakatime/vim-wakatime')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('morhetz/gruvbox')
call dein#add('jez/vim-better-sml')
call dein#add('w0rp/ale')
call dein#add('sainnhe/edge')
" call dein#add('nvim-treesitter/nvim-treesitter')
call dein#add('fatih/vim-go')
call dein#add('sheerun/vim-polyglot')
call dein#add('preservim/nerdtree')
call dein#add('tpope/vim-fugitive')
call dein#add('mhinz/vim-signify')
call dein#add('arzg/vim-substrata')
call dein#add('junegunn/rainbow_parentheses.vim')

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <C-n>  deoplete#manual_complete()

" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox

:set number relativenumber

set t_Co=256
set termguicolors


let g:edge_style = 'neon'
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1
colorscheme edge
highlight Normal ctermfg=grey ctermbg=black


autocmd TextChanged,TextChangedI <buffer> silent write

:set tabstop=4
:set shiftwidth=4
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tagbar#enabled = 0

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_test_show_name = 1
" NerdTree
" map <C-z> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

map <Enter> o<ESC>
map <S-Enter> O<ESC>
" autocmd BufEnter NERD_tree_* | execute 'normal R'

map <C-L> gt
map <C-H> gT

" change the leader key from "\" to ";" ("," is also popular)
let mapleader=";"

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

" Toggle NERDTree
" Can't get <C-Space> by itself to work, so this works as Ctrl - space - space
" https://github.com/neovim/neovim/issues/3101
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim#answer-24550772
"nnoremap <C-Space> :NERDTreeToggle<CR>
"nmap <C-@> <C-Space>
nnoremap <silent> <Space> :NERDTreeToggle<CR>

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" use double-Esc to completely clear the search buffer
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" use space to retain the search buffer and toggle highlighting off/on
" nnoremap <silent> <Space> :set hlsearch!<CR>

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
set autowrite
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

let g:go_jump_to_error = 0
let g:go_list_type = "quickfix"

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <leader>e :call TermToggle(12)<CR>
inoremap <leader>e <Esc>:call TermToggle(12)<CR>
tnoremap <leader>e <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END
