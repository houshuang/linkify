# encoding: utf-8

# searches the Chrome history for
def chrome_search(search, limit=5)
  searchword = "%#{search}%"
  urls = Url.where("title LIKE :search", {:search => searchword})

  # get newest hit
  time_urls = Array.new
  urls.each do |u|
    time = 0
    u.visits.each do |v|
      vtime = v.visit_time.to_i
      time = vtime if time < vtime
    end
    time_urls << [time, u.title, u.url]
  end

  # get most recent hits
  time_urls.sort! {|x, y| y[0] <=> x[0]}
  return time_urls[0..limit-1].map {|x| [ "GC: #{x[1]}", x[2]] }
end