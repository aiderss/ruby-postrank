require 'net/http'
require 'uri'
require 'cgi'

module PostRank
  class Feed
    @@baseurl = 'http://api.postrank.com/v2/feed'

    attr_reader :id, :url, :xml, :title, :description, :fav_icon, :old_id
    
    def entries(opts={})
      clean(opts)
      u = "#{@@baseurl}/#{@id}?appkey=#{Connection.instance.appkey}&format=json"
      u << "&level=#{opts[:level]}" unless opts[:level].nil?
      u << "&num=#{opts[:num]}" unless opts[:num].nil?
      u << "&start=#{opts[:start]}" unless opts[:start].nil?
      u << "&q=#{opts[:q]}" unless opts[:q].nil?

      d = JSON.parse(Net::HTTP.get(URI.parse(u)))
      raise FeedException.new(d['error']) unless d['error'].nil?
      d['items'].collect { |item| PostRank::Entry.new(item) }
    end

    def topposts(opts={})
      clean(opts)

      u = "http://api.postrank.com/v1/top_posts?appkey=#{Connection.instance.appkey}&format=json"
      u << "&feed_id=#{@old_id}&period=#{opts[:period]}"
      u << "&num=#{opts[:num].nil? ? 10 : opts[:num]}"

      d = JSON.parse(Net::HTTP.get(URI.parse(u)))
      raise FeedException.new(d['error']) unless d.is_a?(Array) || d['error'].nil?
      d.collect { |item| PostRank::Entry.new(item) }
    end

    class << self
      def find_by_url(url)
        u = "#{@@baseurl}/info?appkey=#{Connection.instance.appkey}&id=#{url}&format=json"
        d = JSON.parse(Net::HTTP.get(URI.parse(u)))
        raise UnknownFeedException.new(d['error']) unless d['error'].nil?
        Feed.new(d)
      end

      def find(id)
       u = "#{@@baseurl}/#{id}/info?appkey=#{Connection.instance.appkey}&format=json"  
       d = JSON.parse(Net::HTTP.get(URI.parse(u)))
       raise UnknownFeedException.new(d['error']) unless d['error'].nil?
       Feed.new(d)
      end
      alias find_by_id find
    end

    def to_s
      "#{@title} -- #{@description}"
    end

    private

    def initialize(info={})
      @id = info['id']
      @old_id = info['feed_id']
      @url = info['link']
      @xml = info['xml']
      @title = info['title']
      @description = info['description']
    end

    def clean(opts)
      if opts[:num]
        opts[:num] = opts[:num].to_i
        opts[:num] = 10 if opts[:num] < 1 || opts[:num] > 30
      end

      if opts[:start]
        opts[:start] = opts[:start].to_i
        opts[:start] = 0 if opts[:start] < 0
      end

      # level is a number or a PostRank::Level
      if opts[:level]
        if opts[:level].is_a?(Fixnum)
          opts[:level] = 1.0 if opts[:level] < 1.0
          opts[:level] = 10.0 if opts[:level] > 10.0
        elsif !%w(all good great best).member? opts[:level]
          opts[:level] = PostRank::Level::ALL
        end
      end
    
      opts[:period] = PostRank::Period::AUTO unless %w(day week month year auto).member? opts[:period]
      opts[:q] = CGI::escape(opts[:q]) if opts[:q]
    end
  end
end