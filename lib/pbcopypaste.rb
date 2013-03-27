# encoding: utf-8

# writes text to clipboard, using a pipe to avoid shell mangling
# rewritten using osascript for better UTF8 support (from http://www.coderaptors.com/?action=browse&diff=1&id=Random_tips_for_Mac_OS_X)
def pbcopy(text)
  # work around, ' wrecks havoc on command line, but also caused some weird regexp substitution
  File.open("/tmp/script.scpt", 'w') {|f| f << "set the clipboard to \"#{text}\""}
  `osascript /tmp/script.scpt`
end

# gets text from clipboard
def pbpaste
  a = IO.popen("osascript -e 'the clipboard as unicode text' | tr '\r' '\n'", 'r+').read
  a.strip.force_encoding("UTF-8")
end
