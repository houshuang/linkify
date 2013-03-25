# Linkify

Attempt at a simple tool for quickly adding MarkDown (or other) links. Currently scans the
Chrome history, will eventually add data source plugins for blog posts, wiki pages, Slideshare,
YouTube, etc.

## Usage
Use for example Keyboard Maestro to set up a shortcut, which copies the selected text to clipboard,
and triggers linkify.rb. The result will be put on the clipboard (and Keyboard Maestro can paste it)

## Examples
- markdown - will search for markdown, and create a link with markdown as link text
- I like [Markdown - searches for Markdown, whole is used for link text
- Markdown] is awesome - similar to above
- I like [Markdown] and I cannot lie - similar to above
- Marco's markup language{markdown} - searches for markdown, but does not include it in the link text

## Todo
- Add more data sources - blog posts based on nanoc directory
- Make more configurable (right now wiki pages are global variables in dokuwiki.rb)
- Make it easier to specify which wiki subfolders to look in (ie. not clip, ref etc)
- Make it easier to prune files from selection list (ie localhost/)

## Blue sky
- Learn which links I use often (doesn't make much sense since the list of links is generated dynamically)

## License
Released under Public domain.