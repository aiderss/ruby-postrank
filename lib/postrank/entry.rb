module PostRank
  class Entry
    attr_accessor :id, :pubdate, :title, :postrank, :postrank_color
    attr_accessor :description,:content, :original_link, :link
   
    def initialize(item={})
      @title = item['title']
      @pubdate = item['pubdate'] ? Time.at(item['pubdate']) : nil
     
      @link = item['link']
      @original_link = item['original_link']
     
      @postrank = item['postrank']
      @postrank_color = item['postrank_color']
    end
  end
end