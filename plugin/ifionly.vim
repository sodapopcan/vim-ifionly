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
  if s:will_close_win(winnr()) && !s:destructive_jump
    exec s:get_first_modifiable_winnr()."wincmd w"

    return
  endif

  let closewinnrs = s:get_close_winnrs()

  if !len(closewinnrs)
    only
  endif

  while len(closewinnrs)
    exec closewinnrs[len(closewinnrs) - 1]."quit"
    let closewinnrs = s:get_close_winnrs()
  endwhile
endfunction

function! s:get_close_winnrs()
  return filter(range(1, winnr('$')), 's:will_close_win(v:val)')
endfunction

function! s:get_first_modifiable_winnr()
  for i in range(1, winnr('$'))
    if !s:will_close_win(i)
      return i
    endif
  endfor
endfunction

function! s:will_close_win(nr) abort
  if index(s:filetypes, getbufvar(winbufnr(a:nr), '&ft')) >= 0
    return 0
  endif

  if !getbufvar(winbufnr(a:nr), '&modifiable')
    return 1
  endif

  return 0
endfunction
