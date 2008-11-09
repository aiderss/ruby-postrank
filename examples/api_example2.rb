#!/usr/bin/env ruby

require 'rubygems'
require 'postrank'

include PostRank

conn = Connection.instance
conn.appkey = "everburning.com/ruby-postrank"

feedUrl = "http://feeds.feedburner.com/spaetzel"
puts "Running PostRank tests on #{feedUrl}"

f = Feed.find_by_url(feedUrl)
puts "Feed Id is #{f.id}"

entries = f.entries
puts "The PostRank of '#{entries[5].title}' is '#{entries[5].postrank}'"

entry = f.topposts(:period => Period::YEAR, :count => 1).first
puts "The top post in the last year is '#{entry.title}' with a PostRank of '#{entry.postrank}'"

urls = ["http://flickr.com/photos/14009462@N00/2654539960/",
        "http://www.flickr.com/photos/21418584@N07/2447928272/",
        "http://www.flickr.com/photos/pilou/2655293624/"]

PostRank::PostRank.calculate(urls).each do |entry|
  puts "The Thematic PostRank of '#{entry.original_link}' is '#{entry.postrank}'"
end

f2 = Feed.find_by_url("http://feeds.feedburner.com/deysca")

PostRank::PostRank.calculate(["http://feeds.feedburner.com/~r/Deysca/~3/329747930/",
             "http://feeds.feedburner.com/~r/spaetzel/~3/326933691/"],
            :feeds => [f, f2]).each do |entry|
  puts "The Feed thematic PostRank of '#{entry.original_link}' is '#{entry.postrank}'"
end

