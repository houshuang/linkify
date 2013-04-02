require 'curb'
require 'base64'
require 'json'

# uses Bing search API to get results (needs Bing_authkey in settings.rb)
# from http://stackoverflow.com/questions/13841104/bing-search-api-via-ruby-curb

def bing_search(search, limit=5)
  authKey = Base64.strict_encode64("#{Bing_authkey}:#{Bing_authkey}")
  http = Curl.get("https://api.datamarket.azure.com/Bing/Search/Web", {:$format => "json",
    :Query => "'#{search}'"}) do |h|
      h.headers['Authorization'] = "Basic #{authKey}"
  end
  results = JSON.parse(http.body_str)
  res = results["d"]["results"].map { |x| [ "Bing: #{x["Title"]}", x["Url"] ] }
  return res[0..limit-1]
end