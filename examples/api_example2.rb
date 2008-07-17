#!/usr/bin/env ruby

require 'rubygems'
require 'postrank'

include PostRank

s = Server.new "com.everburning"

feedUrl = "http://feeds.feedburner.com/spaetzel"
puts "Running PostRank tests on #{feedUrl}"

f = s.feed feedUrl
puts "Feed Id is #{f.feed_id}"

entries = f.entries
puts "The PostRank of '#{entries[5].title}' is '#{entries[5].post_rank}'"

entry = f.top_posts(:period => Period::MONTH, :count => 1).first
puts "The top post in the last month is '#{entry.title}' with a PostRank of '#{entry.post_rank}'"

urls = ["http://flickr.com/photos/14009462@N00/2654539960/",
        "http://www.flickr.com/photos/21418584@N07/2447928272/",
        "http://www.flickr.com/photos/pilou/2655293624/"]

s.post_rank(urls).each do |entry|
  puts "The Thematic PostRank of '#{entry.title}' is '#{entry.post_rank}'"
end

f2 = s.feed("http://feeds.feedburner.com/deysca")

s.post_rank(["http://feeds.feedburner.com/~r/Deysca/~3/329747930/",
             "http://feeds.feedburner.com/~r/spaetzel/~3/326933691/"],
            :feeds => [f, f2]).each do |entry|
  puts "The Feed thematic PostRank of '#{entry.title}' is '#{entry.post_rank}'"
end

