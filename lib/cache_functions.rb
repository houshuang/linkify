# encoding: utf-8

# Gets list of YouTube videos for a given user, returns array of URLs and titles
def youtube_list(user)
  require 'youtube_it'
  client = YouTubeIt::Client.new

  offset = 1
  videos = []
  while true # keep requesting more videos until there are none left
    resp = client.videos_by(:user => 'houshuang', :offset => offset)
    break if resp.videos.size == 0
    offset += 25
    videos = videos + resp.videos.map {|v| ["http://http://www.youtube.com/watch?v=#{v.unique_id}", v.title]}
  end
  return videos
end

def vimeo_list(user)
  require 'vimeo'
  videos = Vimeo::Simple::User.videos(user)
  return videos.map {|v| ["http://vimeo.com/#{v["id"]}", v["title"]]}
end

def slideshare_list(username, apikey, shared_secret) #
  require 'open-uri'
  require 'digest/sha1'

  ts = Time.now.to_i.to_s
  hash = Digest::SHA1.hexdigest(shared_secret + ts)

  resp = open("https://www.slideshare.net/api/2/get_slideshows_by_user?username_for=#{username}&limit=100&api_key=#{apikey}&hash=#{hash}&ts=#{Time.now.to_i}").read

  slideary = []
  resp.scan(%r|<Title>(.+?)</Title>(.+?)<URL>(.+?)</URL>|m) {|match| slideary << [match[2], match[0]]}

  return slideary
end