# encoding: utf-8
$:.push(File.dirname($0))

# pulls down list of youtube, vimeo etc products into a cache file

require 'yaml'
require 'library'
require 'settings'

urls = []
Vimeo_accounts.each {|v| urls = urls + vimeo_list(v)}
Youtube_accounts.each {|v| urls = urls + youtube_list(v)}
Slideshare_accounts.each {|v| urls = urls + slideshare_list(v,
  apikey = Slideshare_apikey, shared_secret = Slideshare_shared_secret) }

File.open(Path + "/cache.txt", "w") {|f| f << YAML::dump(urls)}