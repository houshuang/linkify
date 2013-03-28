prefix = File.dirname(__FILE__) + "/"
$LOAD_PATH.unshift prefix

require 'settings'

Dir.glob(prefix + "lib/*.rb").each do |f|
  require File.expand_path(f)
end