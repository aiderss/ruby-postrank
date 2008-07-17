module PostRank
  class Feed
    attr_accessor :feed_id, :url, :link

    def initialize(server, feed_id, url, link)
      @server = server
      @feed_id = feed_id
      @url = url
      @link = link
    end

    def entries(opts={})
      defs = {:level => Level::ALL, :count => 15, :start => 0}.merge(opts)
      validate_options(defs)

      d = JSON.parse(@server.get(Method::FEED, Format::JSON, [['feed_id', @feed_id],
                                                              ['level', defs[:level]],
                                                              ['num', defs[:count]],
                                                              ['start', defs[:start]]]))
      raise Exception, d['error'] if !d.is_a?(Array) && d.has_key?('error')

      # try to set the feed title as it's provided in the entries hash 
      @title = d.first['feed_title'] if @title.nil? || @title.empty?

      d.collect { |item| Entry.new(item) }
    end

    def top_posts(opts={})
      defs = {:period => Period::AUTO, :count => 15}.merge(opts)
      validate_options(defs)

      d = JSON.parse(@server.get(Method::TOP_POSTS, Format::JSON, [['feed_id', @feed_id], 
                                                                   ['period', defs[:period]],
                                                                   ['num', defs[:count]]]))
      raise Exception, d['error'] if !d.is_a?(Array) && d.has_key?('error')

      d.collect { |item| Entry.new(item) }
    end

    def to_s
      return @title if !@title.nil? && !@title.empty?
      @url
    end

    private
    def validate_options(opts)
      opts[:count] = 1 if opts[:count] < 0
      opts[:count] = 30 if opts[:count] > 30
    end
  end
end

