require 'cgi'
require 'net/http'
require 'uri'

module PostRank
  class Channel
    attr_reader :entries

    @@baseurl = "http://api.postrank.com/v2/channel"

    def self.retrieve(user, opts={})
      clean(opts)
      u = "#{@@baseurl}/#{user}"
      u << "/#{opts[:tags]}" unless opts[:tags].nil?
      u << "?appkey=#{Connection.instance.appkey}&format=json"
      u << "&num=#{opts[:num]}" unless opts[:num].nil?

      d = JSON.parse(Net::HTTP.get(URI.parse(u)))
      raise ChannelException.new(d['error']) unless d['error'].nil?
      d['items'].collect { |item| PostRank::Entry.new(item) }
    end

    private

    def self.clean(opts)
      if opts[:num]
        opts[:num] = opts[:num].to_i
        opts[:num] = 10 if opts[:num] < 1 || opts[:num] > 30
      end

      opts[:tags] = nil if opts[:tags] == ''
      opts[:tags] = CGI::escape(opts[:tags]) if opts[:tags]
    end
  end
end