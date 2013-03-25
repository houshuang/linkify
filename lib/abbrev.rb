# encoding: utf-8

# abbreviates using ... in the middle

def abbrev(text, length=50)
  return text if text.size < length # do nothing if not needed
  ea_side = length / 2
  return text[0..ea_side-1] + "..." + text[-(ea_side-3).. -1]
end