require 'rubygems'
require 'postrank/server'
require 'postrank/feed'
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

  module Method #:nodoc:
    FEED_ID = "feed_id"
    FEED = "feed"
    TOP_POSTS = "top_posts"
    POST_RANK = "postrank"
  end

  module Format #:nodoc:
    JSON = "json"
    XML = "xml"
    RSS = "rss"
  end
end
