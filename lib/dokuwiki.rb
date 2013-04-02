# encoding: utf-8

Wikipath = "/wiki/data/pages"
Wikiurl = "http://reganmian.net/wiki"

# searches Dokuwiki for pages matching search word
# this function is a bit customized because I want to search certain namespaces etc,
# but should be easy to customize
def dokuwiki_search(search, limit=5)
  searchword = "/*" + search.gsub(" ", "_") + "*.txt"

  pages = Dir.glob(Wikipath + searchword, File::FNM_CASEFOLD)
  pagesa = Dir.glob(Wikipath + "/a" + searchword, File::FNM_CASEFOLD)
  pagesresearchr = Dir.glob(Wikipath + "/researchr" + searchword, File::FNM_CASEFOLD)
  pages = pages + pagesa + pagesresearchr
  ary = Array.new
  pages.each do |file|
    file = file[Wikipath.size + 1..-5]
    title = file.gsub("_", " ").split(/ /).each {|word| word.capitalize!}.join(" ")
    url = "#{Wikiurl}/#{file}"
    ary << ["DW: #{title}", url]
  end
  return ary
end