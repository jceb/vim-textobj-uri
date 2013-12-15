" uri.vim:	Textobjects for dealing with URIs
" Last Modified: Sat 14. Dec 2013 12:43:29 +0100 CET
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.1
" Dependecy:	vim-textobj-user
" Copyright:    2013 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file
" TODO:
" - add text objects that match till the start and end of a URI
" - add command URIOpen that takes a URI and opens it with the appropriate handler
" - add mapping to run URIOpen on a visual mode selection
" - add more file type specific positioning patterns
" - support file type specific URI handlers??

if exists('g:loaded_textobj_uri')
	finish
endif


let g:textobj_uri_positioning_patterns_asciidoc = [
 			\ '\(http\|link\|xref\|mailto\|image:\?\|include:\):\zs[^[]\+\[[^]]*\]',
			\ '<<\zs[^,>]\+\(,[^>]\+\)\?>>'
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
			\ 'file:///\(\K[\/.]*\)\+': ':silent !xdg-open "%s"'
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

" Add more patterns and handlers:
" - every backslash (\) needs to be escaped!
" - handler is optional, if not present an error is raised when executed
" :URIPatternAdd spotify:[a-zA-Z0-9]\\+ :silent!\ !spotify-client\ "%s"
"
" Add a <bang> to delete all existing patterns:
" :URIPatternAdd! spotify:[a-zA-Z0-9]\\+ :silent!\ !spotify-client\ "%s"
" 
" A sophisticated handler that extracts a portion of a URI to build a new URI
" with it.  This URI pattern handles bug references in the form of: Bug #1234:
" URIPatternAdd Bug:\\?\ #\\?[0-9]\\+ :exec\ ":!xdg-open\ 'http://forge.univention.org/bugzilla/show_bug.cgi?id=".substitute("%s","^[bB]ug:\\\\?\ #\\\\?\\\\([0-9]\\\\+\\\\)$","\\\\1",'')."'"
command! -bang -nargs=+ URIPatternAdd :call textobj#uri#add_pattern("<bang>", <f-args>)


" Add positioning patterns:
" - \zs specifies the cursor position, every backslash (\) needs to be escaped!
" - optionally specify a number of file types these patterns are only applied to
" :URIPositioningPatternAdd \\[\\{2}\\zs[^][]*\\(\\]\\[[^][]*\\)\\?\\]\\{2} org
command! -bang -nargs=+ URIPositioningPatternAdd :call textobj#uri#add_positioning_pattern("<bang>", <f-args>)

nnoremap go :let url=textobj#uri#open_uri()<Bar>redraw!<Bar>if exists('url') && len(url)<Bar>exec "echom 'Opening " . url . "'"<Bar>else<Bar>echom "No URL found"<Bar>endif<CR>

let g:loaded_textobj_uri = 1
