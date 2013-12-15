" uri.vim:	Textobjects for dealing with URIs
" Last Modified: Sat 14. Dec 2013 12:43:29 +0100 CET
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.1
" Dependecy:	vim-textobj-user
" Copyright:    2013 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file

if exists('g:loaded_textobj_uri')
	finish
endif


let g:textobj_uri_positioning_patterns_asciidoc = [
 			\ '\(http\|link\|xref\|mailto\|image:\?\|include:\):\zs[^[]\+\[[^]]*\]',
			\ '<<\zs[^,>]\+\(,[^>]\+\)\?>>',
			\ ]

let g:textobj_uri_positioning_patterns_markdown = [
 			\ '\[[^]]*\](\zs[^)]\+)',
 			\ '\[[^]]\+\] \?[\zs[^]]\+]',
			\ ]

let g:textobj_uri_positioning_patterns_org = [
 			\ '\[\{2}\zs[^][]*\(\]\[[^][]*\)\?\]\{2}',
 			\ ]

let g:textobj_uri_positioning_patterns = [
			\ ]

let g:textobj_uri_patterns = {
			\ '\(http\|https\|ftp\):\/\/[a-zA-Z0-9:@_-]*\(\.[a-zA-Z0-9][a-zA-Z0-9-]*\)*\(:\d+\)\?\(\/[a-zA-Z0-9_\/.\-+%#?&=;@$,!''*~]*\)\?': ':silent !xdg-open "%s"',
			\ 'mailto:[a-zA-Z0-9._]\+@[a-zA-Z0-9-]*\(\.[a-zA-Z0-9][a-zA-Z0-9-]*\)*': ':silent !xdg-open "%s"',
			\ 'file:///\(\K[\/.]*\)\+': ':silent !xdg-open "%s"',
			\ }

let g:textobj_uri_search_timeout = 100

call textobj#user#plugin('uri', {
			\ 'uri': {
			\ '*select-a-function*': 'textobj#uri#selecturi_a',
			\ 'select-a': 'au',
			\ '*select-i-function*': 'textobj#uri#selecturi_i',
			\ 'select-i': 'iu',
			\ },
			\ })

command! -bang -nargs=+ URIPatternAdd :call textobj#uri#add_pattern("<bang>", <f-args>)
command! -bang -nargs=+ URIPositioningPatternAdd :call textobj#uri#add_positioning_pattern("<bang>", <f-args>)

nnoremap go :let url=textobj#uri#open_uri()<Bar>redraw!<Bar>if exists('url') && len(url)<Bar>exec "echom 'Opening " . url . "'"<Bar>else<Bar>echom "No URL found"<Bar>endif<CR>

let g:loaded_textobj_uri = 1
