#!/usr/bin/env ruby
      
require 'rubygems'
require 'postrank'
      
include PostRank

conn = Connection.instance
conn.appkey = "everburning.com/ruby-postrank"

eb = Feed.find_by_url("http://everburning.com")
    
puts "The GREAT everburning feeds"
eb.entries(:level => Level::GREAT).each do |entry|
  puts entry.title
end 

puts "\nThe top 5 posts in the last week on everburing"
eb.topposts(:period => Period::WEEK).each do |entry|
  puts "#{entry.title} -- #{entry.post_rank} -- #{entry.post_rank_color}"
end

puts "\nGet thematic PostRanked items"
PostRank::PostRank.calculate(["http://flickr.com/photos/14009462@N00/2654539960/",
                  "http://www.flickr.com/photos/21418584@N07/2447928272/",
                  "http://www.flickr.com/photos/pilou/2655293624/"]).each do |entry|
  puts "#{entry.original_link} #{entry.postrank}"
end

puts "\nGet PostRanked items"
PostRank::PostRank.calculate(['http://everburning.com/news/on-recent-media/',
                  'http://everburning.com/news/californication/',
                  'http://everburning.com/news/the-weary-traveler/'],
            :feeds => [eb]).each do |entry|
  puts "#{entry.original_link} #{entry.postrank}"
end

