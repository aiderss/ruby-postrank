require 'rubygems'
require 'json'

require 'postrank/connection'
require 'postrank/channel'
require 'postrank/feed'
require 'postrank/subscription'
require 'postrank/user'
require 'postrank/postrank'
require 'postrank/entry'

module PostRank #:nodoc:
  module Level
    ALL = "all"
    GOOD = "good"
    GREAT = "great"
    BEST = "best"
  end

  module Period
    DAY = "day"
    WEEK = "week"
    MONTH = "month"
    YEAR = "year"
    AUTO = "auto"
  end

  module Format #:nodoc:
    JSON = "json"
    XML = "xml"
    RSS = "rss"
  end
  
  class APIException < Exception
  end

  class UnknownFeedException < APIException
  end
  
  class FeedException < APIException
  end
  
  class ChannelException < APIException
  end
  
  class URLException < APIException
  end
  
  class PostRankException < APIException
  end
  
  class CredentialsException  < APIException
  end
end
