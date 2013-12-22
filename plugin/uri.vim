" uri.vim:	Textobjects for dealing with URIs
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.3
" Dependecy:	vim-textobj-user
" Copyright:    2013 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file

if exists('g:loaded_uri')
	finish
endif

command! -bang -nargs=+ URIPatternAdd :call textobj#uri#add_pattern("<bang>", <f-args>)
command! -bang -nargs=+ URIPositioningPatternAdd :call textobj#uri#add_positioning_pattern("<bang>", <f-args>)

nnoremap <Plug>TextobjURIOpen :<C-u>let url=textobj#uri#open_uri()<Bar>redraw!<Bar>if exists('url') && len(url)<Bar>exec "echom 'Opening " . url . "'"<Bar>else<Bar>echom "No URL found"<Bar>endif<CR>

if ! hasmapto('<Plug>TextobjURIOpen', 'n')
	nmap go <Plug>TextobjURIOpen
endif

let g:loaded_uri = 1
