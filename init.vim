"--------------------------------------------------------
" 基本設定
"--------------------------------------------------------
set noswapfile      " スワップファイルを作らない
"set hidden         " 編集中でも、保存しないで他のファイルを開けるようにする
set confirm         " ファイルを保存していない場合に、ファイルの保存を確認するダイアログを出す
set cmdheight=2     " 画面下部のコマンドラインの高さ
set showcmd         " 入力したコマンドをステータスラインに表示
set scrolloff=5     " カーソルの上または下に表示される最小限の行数。5に設定してあるので、下に5行は必ず表示される
set vb t_vb=        " ビープを鳴らさない
set mouse=a         " 全モードでマウスを有効化
set viminfo+=!      " yankring用に!を追加
set shellslash      " パス区切りをスラッシュにする
set backspace=indent,eol,start  " BS でiなんでも消せるようにする
set formatoptions+=mM           " 整形オプションにマルチバイト系を追加
set clipboard=unnamed           " OSクリップボード使用
set ambiwidth=single            " □とか○の文字があってもカーソル位置がずれないようにする
set formatoptions+=mM           "整形オプ
set laststatus=2                "ステータスライン2行
set tags+=tags                  "タグジャンプ
set nowrapscan                  "検索が終了したら上に戻らない

"--------------------------------------------------------
" 表示
"--------------------------------------------------------
set number      " 行番号を表示
set showmatch   " 括弧の対応をハイライト
set matchtime=0 " 括弧の対応ハイライトまでの表示時間"
set matchpairs& matchpairs+=<:>  " HTMLタグ用の<>ハイライト設定"
set cursorline  " カーソル行のハイライト
set title        "ウィンドウのタイトルを書き換える
set showmode        "現在のモードを表示

" カラー設定
syntax on       "シンタックスハイライト
set background=dark


" 特殊文字(SpecialKey)の見える化
set list
set listchars=eol:↲,tab:▸\
"SpecialKey term=underline ctermfg=darkgray guifg=darkgray

" 全角スペースのハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" Rubyの対応するdo〜endにカーソル移動を可能にする。
source $VIMRUNTIME/macros/matchit.vim

" WSLでカーソルを見やすくするように
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"--------------------------------------------------------
" エンコード
"--------------------------------------------------------

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,sjis
set fileformats=unix,dos,mac

"--------------------------------------------------------
" 追加のファイルファイプ設定
"--------------------------------------------------------

" slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

"--------------------------------------------------------
" インデント設定
"--------------------------------------------------------

set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set cindent             "Cプログラムファイルの自動インデントを始める
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set tabstop=2           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=2        "自動インデントで入る空白数
set softtabstop=0       "キーボードから入るタブの数
set expandtab           "タブを無効化（タブの代わりにスペースを使う）

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php         setlocal sw=4 sts=4 ts=4 et
endif

"--------------------------------------------------------
" プロバイダー設定 
"--------------------------------------------------------

if has('nvim')
  let g:python_host_prog  = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

"--------------------------------------------------------
" カーソル下の単語を置換する設定
"--------------------------------------------------------
" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s /' . expand('<cword>') . '/'
vnoremap <expr> c* ':s /' . expand('<cword>') . '/'

"--------------------------------------------------------
" カーソル下のタグジャンプを別ウインドウで表示
"--------------------------------------------------------
" C-h C-kでカーソル下のキーワードに宅ジャンプ
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

"--------------------------------------------------------
" Alignを日本語環境で使用するための設定
"--------------------------------------------------------
:let g:Align_xstrlen = 3

"--------------------------------------------------------
" カーソル下の単語をvimgrepする設定
"--------------------------------------------------------


" C-gでカーソル下の選択された文字列をvimgrep
"nnoremap <C-g> :vimgrep @* **/* \|cw<CR>
"vnoremap <C-g> :vimgrep @*  **/* \|cw<CR>
"うまく動かん

"--------------------------------------------------------
" fcitxでESCでIMEをOFFする設定
" fcitxを使っていることが前提
"--------------------------------------------------------

let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
autocmd insertenter * call Fcitx2en()
autocmd insertenter * call Fcitx2zh()

"--------------------------------------------------------
" ビジュアルモードで勝手に小文字化してしまうのを回避
"--------------------------------------------------------

vnoremap u <Nop>
vnoremap U <Nop>
vmap <Leader>u u
vmap <Leader>U u

"---------------------------
" パッケージ管理 Dein Settings.
"---------------------------

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endi

"colorscheme mrkn256
" syntax enable
