#!/usr/bin/env ruby

require 'rubygems'
require 'postrank'

include PostRank

s = Server.new("com.everburning")

puts "Using API version: #{Server.api_version}"
puts "PostRank Server: #{s.server}:#{s.port}"

# Retrieve the feed for everburning.com
eb = s.feed("http://everburning.com")
perplex = s.feed("http://perplexity.org")

puts eb

# Retrieve the first 15 Great level entries
puts "Getting GREAT entries"
eb.entries(Level::GREAT).each do |entry|
  puts entry
end

# Retrieve items 15-45 of the All feed
puts "\nGetting ALL entries between 15 and 45"
eb.entries(Level::ALL, 30, 15).each do |entry|
  puts entry
end

# Retrieve the first 15 top posts in the last week
puts "\nGetting top 15 posts from last week"
eb.top_posts(Period::WEEK).each do |entry|
  puts entry
end

# Retrieve the thematic postrank
puts "\nGetting thematic postrank"
s.post_rank(['http://everburning.com/as',
             'http://blah.com']).each do |post|
  puts post
end

# Retrieve the postrank
puts "\nGetting postrank"
s.post_rank(['http://ever...', 'http://blah'],
            [eb, perplex]).each do |post|
  puts post
end

