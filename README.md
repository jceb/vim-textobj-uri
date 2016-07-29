vim-textobj-uri
===============

Text objects for dealing with URIs and passing them on to other
programs/handlers.

## Installation
I recommend installing [pathogen.vim](https://github.com/tpope/vim-pathogen),
and then execute the following commands:

1. Install [vim-textobj-user](https://github.com/kana/vim-textobj-user)
2. Install [vim-textobj-uri](https://github.com/jceb/vim-textobj-uri)

     cd ~/.vim/bundle
     git clone https://github.com/jceb/vim-textobj-uri.git

## Usage
Once installed, vim-textobj-uri provides these text objects for dealing with
URIs:
- `au` refers to a whole URI including trailing spaces.  Example: `cau` changes
  the URI the cursor is on, including trailing spaces
- `iu` refers to a whole URI without trailing spaces.  Example: `ciu` changes
  the URI the cursor is on without trailing spaces

For passing URIs to other programs or handlers, the `go` keybinding is provided.
Example text in Vim:

    some text http://www.|slashdot.org/ some more text

The cursor (`|`) is within the URI.  Typing `go` will open this URI in the
default web browser on Linux systems.

## Customization
All configuration is stored in global variables starting with `g:textobj_uri_`.

### Add more patterns and handlers
With the following command custom patterns and handlers can be specified:

    :URIPatternAdd <PATTERN> [<HANDLER>] [<FILETYPE> [<FILETYPE>]]

During initialisation of vim the command `:URIPatternAdd` might not be
available, yet.  Another way to add a pattern is to use the following function
call:

	:call textobj#uri#add_pattern(<CLEAR_PATTERNS>, <PATTERN>, [<HANDLER>], [<FILETYPE>, [<FILETYPE>]])

Integration with other programs is done through a connection of a certain regex
pattern with a handler.  The handler is optional, it's only used by the `go`
keybinding.

Example:

    :URIPatternAdd spotify:[a-zA-Z0-9]\\+ :silent\ !spotify-client\ "%s"

For both, pattern and handler, spaces need to be escaped with backslash (`\`).
By adding a bang (`!`) to the command all existing patterns are cleared and
replaced by the new pattern.

The pattern is `spotify:[a-zA-Z0-9]\\+`, it could be anything that should be a
URI.

The handler is `:silent\ !spotify-client\ "%s"`.  Handlers are either vim
commands starting with a colon (`:`) or vim normal mode commands not starting
with colon.  If `%s` is present in the handler it will be replaced with URI.
Attention, special characters will not be escaped!  In addition, `g:textobj_uri`
will be set to URI.  It might be safter to use the variable to access URI.

If the pattern contains a sub-expression than the match of the first
sub-expression is returned as URI.  This makes it easy to take only a portion of
the URI for further processing.  Sub-expressions are enclosed by `\(` and `\)`.
Example pattern:

    spotify:\\([a-zA-Z0-9]\\+\\)

The pattern matches a spotify URI but only the portion after the colon is passed
on to the handler.


It is also possible to build sophisticated handlers that extract a portion of a
URI to process it further.  E.g. this URI pattern handles bug references in the
form of: Bug #1234.  It builds a new URL from a static string and the extracted
bug id:

    :URIPatternAdd Bug:\\?\ #\\?[0-9]\\+ :exec\ ":!silent\ xdg-open\ 'http://forge.univention.org/bugzilla/show_bug.cgi?id=".substitute("%s","^[bB]ug:\\\\?\ #\\\\?\\\\([0-9]\\\\+\\\\)$","\\\\1",'')."'"

The above example can also be achieved using sub-expressions:

    :URIPatternAdd Bug:\\?\ #\\?\\([0-9]\\+\\) :silent\ !xdg-open\ 'http://forge.univention.org/bugzilla/show_bug.cgi?id=%s'

### Add positioning patterns
In markup languages URIs consist of more than the plain URI.  In addition to the
URI there is a special syntax for combining it with, i.e. a description.  To
support also these types of URIs so called positioning patterns can be
specified.  These patterns contain the special vim-regex expression `\zs` which
defines the position where the actual URI starts.  The cursor will be put at
this position and than the URI patterns are applied.

The following command specifies a positioning pattern:

    :URIPositioningPatternAdd <PATTERN> [<FILETYPE> [<FILETYPE>]]

During initialisation of vim the command `:URIPatternAdd` might not be
available, yet.  Another way to add a pattern is to use the following function
call:

	:call textobj#uri#add_positioning_pattern(<CLEAR_PATTERNS>, <PATTERN>, [<FILETYPE>, [<FILETYPE>]])

Example:

 	:URIPositioningPatternAdd \[[^]]*\](\zs[^)]\+) markdown

This is a link pattern in Markdown syntax.  The cursor can be anywhere on this
link, using the text objects or triggering the handler will move it to the URI
and will work only on it.

1. Initial text, cursor is represented by `|`:


    some text \[Link |description\](http://www.slashdot.org/)

2. Text after changing the URI by typing `ciu`:


    some text \[Link description\](|)

## TODO
- add text objects that match till the start and end of a URI
- add command URIOpen that takes a URI and opens it with the appropriate handler
- add mapping to run URIOpen on a visual mode selection
- add more file type specific positioning patterns

## License
MIT License, see LICENSE file
