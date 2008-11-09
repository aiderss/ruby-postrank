module PostRank
  class Subscription
    attr_accessor :id, :feed, :postrank, :filter, :tags, :updated, :created
    
    class << self
      @@base_path = "/myfeeds/subscriptions"
      
      def find(id=:all)
        id = id.to_sym
        if id == :all || id == :first
          subs = []
          JSON.parse(Connection.instance.get("#{@@base_path}.js")).each do |doc|
            subs << Subscription.json_create(doc['subscription'])
          end
          
          id == :first ? subs.first : subs
        else
          Subscription.json_create(JSON.parse(
                            Connection.instance.get("#{@@base_path}/#{id}.js"))['subscription'])
        end
      end
      alias find_by_id find
    
      def find_by_feed(feed)
        Subscription.json_create(JSON.parse(
                          Connection.instance.get("#{@@base_path}/feed/#{feed.id}.js"))['subscription'])
      end
      
      def json_create(o)
        new(:id => o['id'], :feed => o['feed_hash'], :updated => o['updated_at'],
            :created => o['created_at'], :postrank => o['postrank_filter'],
            :filter => o['keyword_filter'], :tags => o['tagged'])
      end
    end
    
    def initialize(opts={})
      @id = opts[:id]
      @updated = opts[:updated]
      @created = opts[:created]
      @postrank = opts[:postrank]
      @filter = opts[:filter]
      @feed = opts[:feed]

      @tags = []
      @tags << opts[:tags].split(/\s+/) unless opts[:tags].nil?
      @tags.flatten!
    end
    
    def feed
      @feed = Feed.find(@feed) unless @feed.is_a?(PostRank::Feed)
    end
    
    def save
      raise APIException.new("Invalid subscription: #{@errors}") unless valid?
    
      if @id.nil?
        Connection.instance.post("#{@@base_path}.js", sub_data)
      else
        Connection.instance.put("#{@@base_path}/#{@id}.js", sub_data)
      end
    end
  
    def delete
      return if @id.nil?
      Connection.instance.delete("#{@@base_path}/#{@id}.js")
    end

    def valid?
      @errors = []
      if @feed.nil? || feed_hash.length != 32
        @errors << "Invalid feed identifier"
        return false
      end
      true
    end

    def feed_hash
      return @feed.id if @feed.is_a?(PostRank::Feed)
      @feed
    end
    
    private
    
    def sub_data
      pr = ''
      if @postrank
        pr = case (@postrank)
          when PostRank::Level::ALL then 1.0
          when PostRank::Level::GOOD then 2.7
          when PostRank::Level::GREAT then 5.4
          when PostRank::Level::BEST then 7.6
          else @postrank
        end
      end
      
      data = {:subscription => {
          :feed_hash => feed_hash,
          :postrank_filter => pr,
          :keyword_filter => @filter || "",
          :tag_list => @tags.join(' ')
        }
      }
    end
  end
end