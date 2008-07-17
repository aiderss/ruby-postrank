module PostRank
  # Holds and provides information about a PostRank feed.
  class Feed
    attr_accessor :feed_id, :url, :link

    # Create a new  PostRank Feed using the provided +server+, +feed_id+,
    # +url+ and +link+. All queries done by this feed will be done through
    # +server+ so it has to be valid
    def initialize(server, feed_id, url, link)
      @server = server
      @feed_id = feed_id
      @url = url
      @link = link
    end

    # Retrieve the entries associated with this feed. The following maybe provided:
    #
    #   :level => PostRank::Level      - The feed level to return GOOD, GREAT, etc
    #   :count => [1..30]              - The number of items to return
    #   :start => integer              - The start index to return from
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

    # Retrieve the top posts for this feed.  The following maybe provided:
    #
    #   :period => PostRank::Period    - The period of time to retrieve from
    #   :count => [1..30]              - The number of items to return
    def top_posts(opts={})
      defs = {:period => Period::AUTO, :count => 15}.merge(opts)
      validate_options(defs)

      d = JSON.parse(@server.get(Method::TOP_POSTS, Format::JSON, [['feed_id', @feed_id], 
                                                                   ['period', defs[:period]],
                                                                   ['num', defs[:count]]]))
      raise Exception, d['error'] if !d.is_a?(Array) && d.has_key?('error')

      d.collect { |item| Entry.new(item) }
    end

    def to_s #:nodoc:
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

