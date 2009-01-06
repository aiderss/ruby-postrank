require 'net/http'
require 'uri'
require 'cgi'

module PostRank
  class Recommend
    @@baseurl = 'http://api.postrank.com/v2/recommend'

    attr_reader :entries
    
    class Entry

      attr_reader :xml, :id, :title
      
      def feed
        unless @feed
          @feed = Feed.find(@id)
        end
        @feed
      end
      
      private
      
      def initialize(opts)
        p opts
        @xml = opts[:xml]
        @id = opts[:id]
        @title = opts[:title]
      end
      
    end

    class << self
      def find(user)
        load("#{@@baseurl}/#{user}?appkey=#{Connection.instance.appkey}&format=json")
      end

      def find_by_user_and_tags(user, tags)
        load("#{@@baseurl}/#{user}?appkey=#{Connection.instance.appkey}&tags=#{CGI::escape(tags)}format=json")
      end
      alias find_by_user find
      
      private
      
      def load(url)
        d = JSON.parse(Net::HTTP.get(URI.parse(url)))
        raise APIException.new(d['error']) if d.is_a?(Hash) && d['error']
        Recommend.new(d)
      end
      
    end

    private

    def initialize(entries)
      @entries = entries.collect do |entry|
        Entry.new({:id => entry['xml_hash'], :xml => entry['xml'], :title => entry['title']})
      end
    end
  end
end