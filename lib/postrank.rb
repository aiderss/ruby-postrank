require 'rubygems'
require 'postrank/server'
require 'postrank/feed'
require 'postrank/entry'

module PostRank
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

  module Method
    FEED_ID = "feed_id"
    FEED = "feed"
    TOP_POSTS = "top_posts"
    POST_RANK = "postrank"
  end

  module Format
    JSON = "json"
    XML = "xml"
    RSS = "rss"
  end
end
