" uri.vim:	Textobjects for dealing with URIs
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		0.3
" Dependecy:	vim-textobj-user
" Copyright:    2013 Jan Christoph Ebersbach
" License:		MIT LICENSE, see LICENSE file

if exists('g:loaded_textobj_uri')
	finish
endif

call textobj#user#plugin('uri', {
			\ 'uri': {
			\ '*select-a-function*': 'textobj#uri#selecturi_a',
			\ 'select-a': 'au',
			\ '*select-i-function*': 'textobj#uri#selecturi_i',
			\ 'select-i': 'iu',
			\ },
			\ })

let g:loaded_textobj_uri = 1
