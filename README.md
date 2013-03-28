# Linkify
Attempt at a simple tool for quickly adding links in Markdown (or other formats), based on websites you have recently visited, and your own projects. Currently scans the
Chrome history, and my wiki pages, and keeps a cache of blog posts, and YouTube, Vimeo and Slideshare items.

**[Blog post](http://reganmian.net/blog/2013/03/28/link-helper-for-markdown-using-google-chrome-history-and-other-sources/)**

[![Screencast](http://reganmian.net/files/linkify-screencast.png)](http://www.youtube.com/watch?v=cDVFjYx7dp4)

## Installation
- Requires rb-appscript for checking which application is running, and which page is open in Chrome
- youtube_it and vimeo gems for fetching object lists
- sqlite3 and active_record for processing Google Chrome history database

Depending on which data sources you will be accessing and whether you need the automatic determination of link format based on app/url, you could possibly remove any of these dependencies.

Edit settings.default.rb and save as settings.rb. The main file is linkify.rb, and you can remove data sources from there easily. update_cache accesses YouTube, Vimeo and Slideshare, as well as my blog (in nanoc format), you can easily add other data sources, it just wants an array of URLs and page titles.

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
- Right now it does a simple page title search, which has to be an exact submatch (case-insensitive), and it only prioritizes based on the order in which I search the categories. It could perhaps be more intelligent about search (fuzzy search), ordering of hits, and maybe even add a Google/Bing etc search if not enough hits are found.
- Make it more generic, and easier to install/configure.

## License
Released under Public Domain or CC Zero. Feel free to give me attribution, also feel free to contact me if you have problems getting it to run.

Stian Håklev, 2013, shaklev@gmail.com, http://reganmian.net/blog