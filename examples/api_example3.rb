require 'postrank'

conn = PostRank::Connection.instance

conn.appkey = 'everburning.com/test'
conn.api_secret = 'lkajds'
conn.api_token = 'asdf'

conn.user_secret = nil
conn.user_token = nil

# Needs to be done the first time the user accesses the API. save the secret/token somewhere
conn.authorization_url
conn.authorize

secret = conn.user_secret
token = conn.user_token

f = PostRank::Feed.find_by_url("http://everburning.com")
f2 = PostRank.Feed.find("ad409984854jk3830292390")

f.entries.each do |entry|
 puts entry.title
end

u = PostRank::User.current
puts u.email
puts u.id

s = PostRank::Subscription.new(...)
s.save

s = PostRank::Subscription.find(id)
s = PostRank::Subscription.find_by_id(id)
s = PostRank::Subscription.find_by_feed(feed)

s = PostRank::Subscription.find(:all)

c = PostRank::Channel.new(tag)
c.entries.each do |entry|
  puts entry.title
end

PostRank::PostRank.calculate([p1, p2, p3], [f1, f2, f3]).each do |feed, postrank, color|
 puts "#{feed} #{postrank} #{color}"
end
