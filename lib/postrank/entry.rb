module PostRank
  # Contains information about a specific entry and it's PostRank value
  class Entry
    attr_accessor :title, :content, :publish_date, :link
    attr_accessor :original_link, :comments, :comment_rss
    attr_accessor :slash_comments, :post_rank, :post_rank_color

    # Create a new entry from the provided hash +item+
    def initialize(item={})
      @title = item['title']
      @content = item['description']
      @publish_date = item['pubdate'] ? Time.at(item['pubdate']) : nil

      @link = item['link']
      @original_link = item['original_link']

      @comments = item['comments']
      @comment_rss = item['comment_rss']
      @slash_comments = item['slash_comments']

      @post_rank = item['postrank']
      @post_rank_color = item['postrank_color']
    end
 
    # Retrieve the title for the given entry
    def title
      @title || @original_link
    end

    def to_s #:nodoc:
      "#{original_link} -- Post rank: #{post_rank}"
    end
  end
end
