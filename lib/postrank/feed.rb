module PostRank
  class Feed
    attr_accessor :feed_id, :url, :link
    def initialize(server, feed_id, url, link)
      @server = server
      @feed_id = feed_id
      @url = url
      @link = link
    end

    def entries(level=Level::ALL, count=15, start=0)
      count = 1 if count < 0
      count = 30 if count > 30

      d = JSON.parse(@server.get(Method::FEED, Format::JSON, [['feed_id', @feed_id], ['level', level], 
                                                              ['num', count], ['start', start]]))
      raise Exception, d['error'] if !d.is_a?(Array) && d.has_key?('error')

      # try to set the feed title as it's provided in the entries hash 
      @title = d.first['feed_title'] if @title.nil? || @title.empty?

      d.collect { |item| Entry.new(item) }
    end

    def top_posts(period=Period::AUTO, count=15)
      count = 1 if count < 0
      count = 30 if count > 30

      d = JSON.parse(@server.get(Method::TOP_POSTS, Format::JSON, [['feed_id', @feed_id], 
                                                                   ['period', period],
                                                                   ['num', count]]))
      raise Exception, d['error'] if !d.is_a?(Array) && d.has_key?('error')

      d.collect { |item| Entry.new(item) }
    end

    def to_s
      return @title if !@title.nil? && !@title.empty?
      @url
    end
  end
end

