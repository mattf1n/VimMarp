" Vim global plugin for rendering marp presentations as you write them
" Last change: 17 June 2020
" Maintainer: mattf1n <matthewbfinlayson@gmail.com>
" License: This file is placed in the public domain.

if exists('g:loaded_VimMarp')
  finish
endif
let g:loaded_VimMarp = 1

if !exists(":VimMarp")
  let s:toggle = 1
  function s:BeginMarp()
    if s:toggle
      if &filetype == 'markdown'
        echo 'Rendering and opening...'
        AsyncRun marp "%" --pdf && open "%:r".pdf && marp "%" --pdf --watch
        let s:toggle = 0
      else
        echo 'Filetype is not markdown'
      endif
    else
      AsyncStop
      echo 'Rendering stopped'
      let s:toggle = 1
    endif
  endfunction
  command VimMarp :call s:BeginMarp()
endif
