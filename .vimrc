set t_Co=256
set tabstop=3
set laststatus=2
set syntax=enable
set background=dark

set number
set ignorecase
set nocompatible
set noshowmode

let g:solarized_termcolors=256

colorscheme solarized

filetype indent on

"hi CursorLine term=bold cterm=bold guibg=Grey40
hi Statusline cterm=none ctermbg=8 ctermfg=7 guibg=darkgrey guifg=lightgrey
hi VimStatus cterm=bold ctermbg=darkgrey ctermfg=grey guibg=darkred guifg=grey
" hi VimStatusTransition cterm=bold ctermbg=lightgrey ctermfg=black guibg=lightgrey guifg=black
" hi FileNameTransition ctermbg=lightgrey guibg=lightgrey

function! VimStatusMode()
    let s:StatuslineMode=mode()
    if (s:StatuslineMode == 'n')
        exec 'hi VimStatus cterm=bold ctermbg=10 ctermfg=8 guibg=lightgreen guifg=grey'
		return 'N' 
    elseif (s:StatuslineMode == 'i')
		exec 'hi VimStatus cterm=bold ctermbg=red ctermfg=grey guibg=red guifg=grey'
		return 'I'
	else
		return 'U'
    endif
endfunc

function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0B'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

" function! GitInfo()
"  let git = fugitive#head()
"  if git != ''
"    return ' '.fugitive#head()
"  else
"    return ''
"endfunction

function! FileFlags()
  if (&modified && &readonly)
    return '[+🔒]'
  endif
  if (&modified)
    return '[+]'
  endif
  if (&readonly)
    return '[🔒]'
  endif
  return ''
endfunction

set statusline=				 	" Clear StatusLine	
set statusline+=%#VimStatus#
set statusline+=\ %{VimStatusMode()}
"set statusline+=%#VimStatusTransition#
" set statusline+=%#FileNameTransition#
"set statusline+=▄ "Basic color && and mode
set statusline+=\ %#Statusline#
set statusline+=\ %t				" File name
" set statusline+=\ %{GitInfo()}		" Git?
set statusline+=\ %{FileFlags()}		" File flags '', [+], [🔒], [+🔒]
set statusline+=%=				" (And jumping to the right)
set statusline+=[%{&fileformat}]
set statusline+=\ %{FileSize()}			" File size
set statusline+=\ \{%l:%L\}			" Column and line
set statusline+=\ @\ %p%%			" % of file
