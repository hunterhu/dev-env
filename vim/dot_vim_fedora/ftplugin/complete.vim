" Auto-braces for c/c++
" Author: Michael Geddes <michaelrgeddes@optushome.com.au>
" Version: 0.2

" Adds braces after if, while 
" Makes sure { doesn't follow 'else' 

if !exists('DoingSOURCE')
  if exists('*ReadFileTypeMap')
	SO <sfile>
	finish
  endif
  if exists("b:did_ftplugin")
	finish
  endif
endif

" This version relies on cindent being set.

" FileTypes: c,cpp
imap <buffer> <cr> <cr><c-r>=<SID>AutoBrace()<cr>
imap <buffer> <m-]> <c-o>]}<c-o>:s/\s\+$//e<cr><c-o>:startinsert<cr><right>

iabbrev <buffer> else <c-r>=<SID>FixElse()<cr>

fun! s:FixElse()
  if &filetype=="cpp" || &filetype=="c"
	let here=strpart(getline('.'),1,col('.'))
	if here=~'}\s*$'
	  let first=strlen(substitute(here,'\s\+$','',''))
	  let attrib=synIDattr(synID(line('.'), first, 1), "name")
	  if attrib !~ '^cComment'
		return "\relse" 
		"\r{\r}\<up>\r"
	  endif
	endif
  endif
  return "else"
endfun

fun! s:AutoBrace()
  if &filetype=="cpp" || &filetype=="c"
	  let l=line('.')
	  let lastattrib=synIDattr(synID(l, 1, 0), "name")
	  if lastattrib != "cParen"
		let l=l-1
		while synIDattr(synID(l,1,0),"name") == "cParen"
		  let l=l-1
		endwhile
		let first=strlen(matchstr(getline(l),'^\s*.'))
		let attrib=synIDattr(synID(l, first, 1), "name")
		if attrib =~ '\<\(cRepeat\|cConditional\)\>' && getline(l) !~ ';\s*$'
		  return "{\r}\<Up>\r"
		endif
	  endif
  endif
  return ""
endfun

