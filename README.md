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

## License
Released under Public domain.