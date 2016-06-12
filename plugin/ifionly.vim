" ifionly.vim - An only slightly smarter :only
" Maintainer:   Andrew Haust <https://www.github.com/sodapopcan>
" Version:      1.0

if exists('g:loaded_ifionly') || &cp
  finish
endif
let g:loaded_ifionly = 1

command! -nargs=0 IfIOnly call <SID>only()

nnoremap <silent> <C-W>O :call <SID>only()<CR>

let s:destructive_jump = get(g:, 'ifionly_destructive_jump', 0)
let s:filetypes = get(g:, 'ifionly_filetypes', [])

function! s:only() abort
  if !s:keepbuf()
    let winnr = winnr()
    while !s:keepbuf()
      wincmd w
      if winnr ==# winnr()
        return
      endif
    endwhile
    if !s:destructive_jump
      return
    endif
  endif

  let winnr = winnr()
  let bufnr = bufnr('%')
  let curwinnr = 0
  let delete_bufnrs = []

  while winnr !=# curwinnr
    wincmd w
    if !s:keepbuf()
      call add(delete_bufnrs, bufnr('%'))
    endif
    let curwinnr = winnr()
  endwhile

  if len(delete_bufnrs)
    for i in delete_bufnrs
      call s:buffocus(i)
      quit
    endfor
  else
    only
  endif

  call s:buffocus(bufnr)
endfunction

function! s:keepbuf() abort
  return &modifiable || index(s:filetypes, &ft) >= 0
endfunction

function! s:buffocus(bufnr) abort
  let switchbuf_cached = &switchbuf
  set switchbuf=useopen
  exec 'sb ' . a:bufnr
  exec 'set switchbuf=' . switchbuf_cached
endfunction
