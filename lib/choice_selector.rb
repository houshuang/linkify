# encoding: utf-8

# presents a dropdown Pasha box with all the options

# keep track of which content types are accessed most frequently
def log_content_type(type)
  File.open(Path + "/content.log", "a") {|f| f << type + "\n"}
end

def format_line(ary)
  return "#{abbrev(ary[0], 70)} || #{abbrev(ary[1], 70)}"
end


def choice_selector(choice_ary)
  require 'pashua'
  include Pashua

  config = "
  *.title = linkify
  cb.type = combobox
  cb.completion = 2
  cb.width = 900
  cb.default = 0: #{format_line(choice_ary[0])}
  cb.tooltip = Choose from the list
  db.type = cancelbutton
  db.label = Cancel
  db.tooltip = Closes this window without taking action" + "\n"

  # insert list of all choices
  choice_ary.each_with_index { |c, i| config << "cb.option = #{i}: #{format_line(c)}\n" }
  pagetmp = pashua_run config
  exit if pagetmp['cancel'] == 1 || pagetmp['cb'] == nil

  idx = pagetmp['cb'].split(":")[0].to_i

  content_type = pagetmp['cb'].split(":")[1].strip
  log_content_type(content_type)

  return choice_ary[idx]
end
