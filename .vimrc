set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/tmp/eperea/minenvconfig/Vundle.vim
call vundle#begin("/tmp/eperea/minenvconfig/vundleplugins")
Plugin 'VundleVim/Vundle.vim' "Do not remove this line
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'thoughtbot/vim-rspec'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'diepm/vim-rest-console'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'prettier/vim-prettier' 
call vundle#end()            " required
filetype plugin indent on    " required

autocmd BufWritePost ~/.vim/doc/* :helptags ~/.vim/doc

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch rspec {spec}"

"Repeat last command in the next tmux pane.
" nnoremap <Leader>e :call <SID>TmuxNextWindow()<CR>
nnoremap <Leader>e :call <SID>TmuxSendKeys()<CR>
nnoremap <Leader>r :call <SID>RunCommand()<CR>
nnoremap <Leader>c :call <SID>TmuxCreateDebugTerm()<CR>
nnoremap <Leader>z :call <SID>TmuxZoomWindow()<CR>

if !exists("g:command")
    let g:command = "echo 'You can set command with let g:command=\"new cmd\"'"
endif

function! s:RunCommand()
    silent !clear
    execute "!" . g:command 
endfunction

function! s:TmuxSendKeys()
  silent! exec "!tmux send-keys -t opstwo.0 tmux send up enter"
  redraw!
endfunction

function! s:TmuxZoomWindow()
  silent! exec "!tmux resize-pane -Z"
  redraw!
endfunction

function! s:TmuxNextWindow()
  silent! exec "!tmux next-window && tmux send up enter"
  redraw!
endfunction

function! s:TmuxCreateDebugTerm()
  silent! exec "!tmux split-window && tmux resize-pane -D 12"
  silent! exec "!cd $(dirname%)"
  redraw!
endfunction

function! s:TmuxRepeatRight()
  silent! exec "!tmux select-pane -R && tmux send up enter && tmux select-pane -L"
  redraw!
endfunction

function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -D && tmux send up enter && tmux select-pane -U"
  redraw!
endfunction

function! s:TmuxRepeatStay()
  silent! exec "!tmux select-pane -l && tmux send up enter"
  redraw!
endfunction

"Nerd tree enablement 
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufNewFile,BufRead *.god set syntax=ruby
" Mappings 
autocmd FileType ruby	let b:dispatch = 'ruby %'
autocmd FileType ruby	let b:start = 'ruby %'
"autocmd BufRead *_spec.rb	let b:dispatch = 'rspec %' 
"autocmd FileType ruby	let b:dispatch = 'rspec %'
autocmd FileType python let b:dispatch = 'python %'
autocmd BufRead sql let b:dispatch = 'ibi sql --format=table "`cat %`"'
autocmd FileType java let b:dispatch = 'javac %'
autocmd FileType java let b:start = 'clear; time java -cp %:p:h %:t:r'
"autocmd FileType java let b:dispatch = 'javac -cp commons-math3-3.4.1.jar %'


"How to comment files 
autocmd BufNewFile,BufRead *.god setlocal commentstring=#\ %s
autocmd Filetype python setlocal commentstring=#\ %s
autocmd Filetype ruby setlocal commentstring=#\ %s
autocmd Filetype perl setlocal commentstring=#\ %s
autocmd FileType java setlocal commentstring=//\ %s


nnoremap <Leader>i :Dispatch <Esc>
nnoremap <Leader>w :w <Esc>

" inoremap <C-i> <Esc> :w <bar> :Dispatch <Esc>
nnoremap <Leader>u :Dispatch! <Esc>
nnoremap <Leader>g :! firefox *.png <Esc>
" nnoremap <Leader>r :Start <Esc>
nnoremap <Leader>o :!clear; ./% <Esc>
nnoremap <Leader>j :join <Esc>
" nnoremap <Leader>t :TagbarToggle<Esc>
nnoremap c[ :botright copen<Esc>
nnoremap 2c[ :botright copen 20<Esc>
nnoremap 3c[ :botright copen 30<Esc>
nnoremap 4c[ :botright copen 40<Esc>
nnoremap c] :cclose<Esc> 
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl <CR><C-l>

" map <Leader>u :call RunDispatch()<CR>
" func! RunDispatch()
" exec "w"
" if &filetype == 'java'
" exec "Dispatch java -cp %:p:h %:t:r"
" elseif &filetype == 'python'
" exec "Dispatch python %"
" elseif &filetype == 'html'
" exec "Dispatch firefox % &"
" endif
" endfunc

"Mapping ctrl r to run current script 
"command R !./%

syntax on "Enable syntax highlighting
set foldmethod=indent

set hlsearch          "Highlight search
"set autoindent  "Auto-indent the next line based on the indent of this one
set noautoindent
"set number      "Show line numbers on the left side of the screen
"set autowrite
"set makeprg=/usr/intel/bin/gmake 
set laststatus=2
set ruler       "show the position indicator in the lower right corner
set expandtab   "use spaces instead of tab characters
set incsearch " Like emacs isearch, go immediately to matches
"set dictionary=/usr/dict/words " Where's the dictionary?
"set keywordprg=ref             " How to look up keywords
"set sm
"set lisp
set tabstop=2              "tab stop
set softtabstop=2     "use the same value as shiftwidth
set shiftwidth=2      "use 4 spaces when using autoindent/cindent
set smarttab          "smart tabs??
set backspace=indent,eol,start
set backspace=2
set pastetoggle=<F9>
set ignorecase
set smartcase
set t_kb= t_kD=[3~
set history=200
set signcolumn=no

function! SaveAndFocus()
  w! /tmp/saved.txt
  Focus source %
endfunction
nnoremap <Leader>s :call SaveAndFocus()<Esc>

" function! FormatPaths()
"   %! grep nfs
"   /\/nfs.*_\d\+\Z
"   let @a = "0nd0gny0P^[lD^["
"   % normal @a
" endfunction
" nnoremap <Leader>f :call FormatPaths()<Esc>

function! Tableize()
  %s/,/|/g
  % Tab /|
  set nowrap
endfunction

nnoremap <Leader>f :call Tableize()<Esc>
