require 'rubygems'
require 'postrank'

conn = PostRank::Connection.instance

u = PostRank::User.current

PostRank::Recommend.find(u.id).entries.each do |entry|
  p entry
end