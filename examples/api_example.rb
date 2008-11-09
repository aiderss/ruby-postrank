#!/usr/bin/env ruby

require 'rubygems'
require 'postrank'

include PostRank

conn = Connection.instance
conn.appkey = "everburning.com/ruby-postrank"

# Retrieve the feed for everburning.com
eb = Feed.find_by_url("http://everburning.com")
perplex = Feed.find_by_url("http://perplexity.org")

puts eb

# Retrieve the first 15 Great level entries
puts "Getting GREAT entries"
eb.entries(:level => Level::GREAT).each do |entry|
  puts entry.title
end

# Retrieve items 15-45 of the All feed
puts "\nGetting ALL entries between 15 and 45"
eb.entries(:count => 30, :start => 15).each do |entry|
  puts entry.title
end

# Retrieve the first 15 top posts in the last week
puts "\nGetting top 15 posts from last week"
eb.topposts(:period => Period::WEEK).each do |entry|
  puts entry.title
end

# Retrieve the thematic postrank
puts "\nGetting thematic postrank"
PostRank::PostRank.calculate(['http://everburning.com/as',
             'http://blah.com']).each do |post|
  puts "#{post.original_link} #{post.postrank}"
end

# Retrieve the postrank
puts "\nGetting postrank"
PostRank::PostRank.calculate(['http://everburning.com', 'http://blah.com'],
            :feeds => [eb, perplex]).each do |post|
  puts "#{post.original_link} #{post.postrank}"
end

