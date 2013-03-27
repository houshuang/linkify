# encoding: utf-8
Path = '/Users/Stian/src/linkify'
# searches the cache
def cache_search(search, limit=5)
  require 'yaml'
  cache = YAML::load(File.read(Path + "/cache.txt"))
  results = cache.select {|c| c[1].downcase.index(search.downcase)}
  return results.map {|x| [x[1], x[0]]}
end
