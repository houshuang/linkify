# encoding: utf-8
$:.push(File.dirname($0))
require 'library'
require 'appscript'

def format_link(text, link, format = 'markdown')
  if format == 'markdown'
    return "[#{text}](#{link})"
  elsif format == 'html'
    return "<a href='#{link}'>#{text}</a>"
  elsif format == 'rtf'
    out = %q|{\rtf1{\field{\*\fldinst{HYPERLINK "!LINK!"}}{\fldrslt !TEXT!}}}|
    out.gsub!("!LINK!", link)
    out.gsub!("!TEXT!", text)
    return out
  elsif format == 'wiki'
    link = link[Wikiserver.size..-1] if link.index(Wikiserver)
    return "[[#{link}|#{text}]]"
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
    fail "Nothing to search for" if selection == '[]'
    search = selection.scan(/\[(.+?)\]/)[0][0].strip
    selection.gsub!(/[\[\]]/, '')
  end
  return search, selection
end

def remove_unwanted(ary)
  newary = []
  ary.each do |a|
    incl = true
    Exclude_patterns.each do |excl|
      incl = false if a[1].index(excl)
    end
    newary << a if incl
  end
  return newary
end

def get_current_app
  app = Appscript.app("System Events")
  return app.application_processes[app.application_processes.frontmost.get.index(true)+1].name.get.strip
end

def cururl
  chrome = Appscript.app("Google Chrome")
  url = chrome.windows[1].active_tab.get.URL.get.strip
  return url
end

selection = pbpaste
search, selection = extract_search(selection)

sc_choices = cache_search(search)
dw_choices = dokuwiki_search(search)
ch_choices_all = chrome_search(search, 20)
ch_choices = remove_unwanted(ch_choices_all)
bg_choices = bing_search(search, 10)

choices = sc_choices + dw_choices + ch_choices + bg_choices

fail "No hits for #{search}" if choices == []

choice = choice_selector(choices)

selection = choice[1] if selection.strip.size == 0 # replace with page title if link text empty

app = get_current_app

format = 'markdown'
format = 'markdown' if app == 'Sublime Text 2'
if app == 'Google Chrome'
  url = cururl
  format = 'markdown'
  format = 'wiki' if url.index("localhost/wiki")
  format = 'rtf' if url.index("mail.google")
  format = 'html' if url.index("reganmian.net/blog")
end

selection = choice[1] if selection.strip.size == 0 # replace with page title if link text empty
out = format_link(selection, choice[1], format)
pbcopy(out)