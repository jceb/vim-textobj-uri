" uri.vim:	Textobjects for dealing with URIs
" Last Modified: Sat 21. Dec 2013 18:58:06 +0100 CET
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Copyright:    2013 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file

if exists('g:loaded_uri')
	finish
endif

command! -bang -nargs=+ URIPatternAdd :call textobj#uri#add_pattern("<bang>", <f-args>)
command! -bang -nargs=+ URIPositioningPatternAdd :call textobj#uri#add_positioning_pattern("<bang>", <f-args>)

nnoremap go :let url=textobj#uri#open_uri()<Bar>redraw!<Bar>if exists('url') && len(url)<Bar>exec "echom 'Opening " . url . "'"<Bar>else<Bar>echom "No URL found"<Bar>endif<CR>

let g:loaded_uri = 1
