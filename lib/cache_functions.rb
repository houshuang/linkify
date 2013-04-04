# encoding: utf-8

# per http://stackoverflow.com/questions/1113422/how-to-bypass-ssl-certificate-verification-in-open-uri
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


# Gets list of YouTube videos for a given user, returns array of URLs and titles
def youtube_list(user)
  require 'youtube_it'
  client = YouTubeIt::Client.new

  offset = 1
  videos = []
  while true # keep requesting more videos until there are none left
    resp = client.videos_by(:user => user, :offset => offset)
    break if resp.videos.size == 0
    offset += 25
    videos = videos + resp.videos.map {|v| ["http://www.youtube.com/watch?v=#{v.unique_id}", "YT: #{v.title}"]}
  end
  return videos
end

def vimeo_list(user)
  require 'vimeo'
  videos = Vimeo::Simple::User.videos(user)
  return videos.map {|v| ["http://vimeo.com/#{v["id"]}", "V: #{v["title"]}"]}
end

def slideshare_list(user, apikey, shared_secret) #
  require 'open-uri'
  require 'digest/sha1'

  ts = Time.now.to_i.to_s
  hash = Digest::SHA1.hexdigest(shared_secret + ts)

  resp = open("https://www.slideshare.net/api/2/get_slideshows_by_user?username_for=#{user}&limit=100&api_key=#{apikey}&hash=#{hash}&ts=#{Time.now.to_i}").read

  slideary = []
  resp.scan(%r|<Title>(.+?)</Title>(.+?)<URL>(.+?)</URL>|m) {|match| slideary << [match[2], "SL: #{match[0]}" ]}

  return slideary
end

def blog_list
  ary = []
  search = Blogpath + "/content/posts/*.md"

  # blog posts
  pages = Dir.glob(search, File::FNM_CASEFOLD)
  pages.each do |p|
    a = File.read(p)
    title = a.scan(%r|^title: (.+?)$|)[0][0].gsub("\"", "")
    y,m,d,slug = /([0-9]+)\-([0-9]+)\-([0-9]+)\-([^\/]+)/.match(p).captures

    url = Blogdomain + "/#{y}/#{m}/#{d}/#{slug[0..-4]}"
    ary << [url, "Blog: #{title}"]
  end

  # pages
  search = Blogpath + "/content/pages/*.md"
  pages = Dir.glob(search, File::FNM_CASEFOLD)
  pages.each do |p|
    a = File.read(p)
    title = a.scan(%r|^title: (.+?)$|)[0][0].gsub("\"", "")
    url = Blogdomain + "/#{p.split("/").last[0..-4]}"
    ary << [url, "Blog: #{title}"]
  end

  return ary
end