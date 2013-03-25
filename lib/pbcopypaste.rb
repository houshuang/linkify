# encoding: utf-8

# writes text to clipboard, using a pipe to avoid shell mangling
# rewritten using osascript for better UTF8 support (from http://www.coderaptors.com/?action=browse&diff=1&id=Random_tips_for_Mac_OS_X)
def pbcopy(text)
  `osascript -e 'set the clipboard to "#{text}"'`
  #IO.popen("osascript -e 'set the clipboard to do shell script \"cat\"'","w+") {|pipe| pipe << text}
end

# gets text from clipboard
def pbpaste
  a = IO.popen("osascript -e 'the clipboard as unicode text' | tr '\r' '\n'", 'r+').read
  a.strip.force_encoding("UTF-8")
end
