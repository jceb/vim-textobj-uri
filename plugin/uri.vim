" uri.vim:	Textobjects for dealing with URIs
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.4
" Dependecy:	vim-textobj-user
" Copyright:    2016 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file

if exists('g:loaded_uri')
	finish
endif

command! -bang -nargs=+ URIPatternAdd :call textobj#uri#add_pattern("<bang>", <f-args>)
command! -bang -nargs=+ URIPositioningPatternAdd :call textobj#uri#add_positioning_pattern("<bang>", <f-args>)

function! s:TextobjURIOpen()
    let l:url = textobj#uri#open_uri()
    redraw!
    if exists('l:url') && len(l:url)
        echom 'Opening "' . l:url . '"'
    else
        echom "No URL found"
    endif
endfunction

nnoremap <Plug>TextobjURIOpen :<C-u>call <sid>TextobjURIOpen()<CR>
command! TextobjURIOpen :call <sid>TextobjURIOpen()

if ! hasmapto('<Plug>TextobjURIOpen', 'n')
	nmap go <Plug>TextobjURIOpen
endif

let g:loaded_uri = 1
