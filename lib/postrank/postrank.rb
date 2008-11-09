module PostRank
  class PostRank
    @@baseserver = 'api.postrank.com'
    @@baseurl = '/v1/postrank'
    
    def self.calculate(urls=[], feeds=[])
       return [] if urls.empty?

       f = feeds
       f = [] if f.nil? || !f.is_a?(Array)

       params = []
       urls.each do |url| 
         raise URLException.new(url) if !valid_url(url)
         params << ['url[]', url]
       end

       f.each do |feed|
         raise FeedException.new(feed) if !feed.is_a?(Feed) || feed.old_id.nil?
         params << ['feed[]', feed]
       end

       u = "#{@@baseurl}?appkey=#{Connection.instance.appkey}&format=json"
       d = JSON.parse(Net::HTTP.new(@@baseserver, 80).post(u, 
                  join_params(params), {'Content-Type' => 'application/json'}).body)       
       raise PostRankException.new(d['error']) unless d['error'].nil?

       ret = []
       urls.each do |url|
         e = Entry.new
         e.original_link = url
         e.postrank = d[url]['postrank']
         e.postrank_color = d[url]['postrank_color']
         ret << e
       end
       ret
    end

    private

    # Regex from: http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
    def self.valid_url(url)
      url =~ /^((http|https):\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
    end
    
    def self.join_params(params)
      params.collect{ |p| p.collect { |e| CGI.escape(e.to_s) }.join('=') }.join('&')
    end
  end
end