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
    if exists('t:ifionly_session_file') && winnr('$') == 1
      let winstate = winsaveview()
      let bufnr = bufnr('')
      exec "silent! source ".t:ifionly_session_file
      call winrestview(winstate)
      exec "b".bufnr
      call s:cleanup()
    else
      let t:ifionly_session_file = tempname().'__ifionly__'.tabpagenr()
      let current_session_options = &sessionoptions
      let current_session = v:this_session
      set sessionoptions-=tabpages sessionoptions-=blank sessionoptions-=options
      exec "mksession! ".t:ifionly_session_file
      only
      let v:this_session = current_session
      let &sessionoptions = current_session_options
      autocmd! TabClosed * call s:cleanup()
    endif
  endif

  while len(closewinnrs)
    exec closewinnrs[len(closewinnrs) - 1]."quit"
    let closewinnrs = s:get_close_winnrs()
  endwhile
endfunction

function! s:get_close_winnrs() abort
  return filter(range(1, winnr('$')), 's:will_close_win(v:val)')
endfunction

function! s:get_first_modifiable_winnr() abort
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

function! s:cleanup() abort
  if exists('t:ifionly_session_file')
    call delete(t:ifionly_session_file)
    unlet t:ifionly_session_file
  endif
endfunction
