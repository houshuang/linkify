# encoding: utf-8
$:.push(File.dirname($0))
require 'library'

def format_link(text, link, format = 'markdown')
  if format == 'markdown'
    return "[#{text}](#{link})"
  elsif format == 'html'
    return "<a href='#{link}'>#{text}</a>"
  end
end

# select search phrase with [], only ] selects to beginning, only [ selects to end
# {} specifies search phrase that is not part of link text (is removed)
# takes selection, returns selection cleaned up, and search text
def extract_search(selection)
  if selection.index("{")
    search = selection.scan(/\{(.+?)\}/)[0][0].strip
    selection.gsub!(/\{(.+?)\}/, '')
  else
    selection = "[#{selection}" unless selection.index('[')
    selection = "#{selection}]" unless selection.index(']')
    search = selection.scan(/\[(.+?)\]/)[0][0].strip
    selection.gsub!(/[\[\]]/, '')
  end
  return search, selection
end

selection = pbpaste
search, selection = extract_search(selection)

# I'll eventually add other data sources here, like own blog posts etc
dw_choices = dokuwiki_search(search)
ch_choices = chrome_search(search, 10)
choices = dw_choices + ch_choices

fail "No hits for #{search}" if choices == []

choice = choice_selector(choices)

selection = choice[1] if selection.strip.size == 0 # replace with page title if link text empty
pbcopy(format_link(selection, choice[1]))