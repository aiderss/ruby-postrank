Gem::Specification.new do |s|
  s.name = %q{postrank}
  s.version = "0.9.1"
  s.authors = ["dan sinclair"]
  s.email = %q{dan@aiderss.com}
  s.homepage = %q{http://http://github.com/dj2/ruby-postrank/wikis/}

  s.summary = %q{PostRank provides simple wrapper around the PostRank.com API.}
  s.description = %q{PostRank provides a simple wrapper around the PostRank.com API.}

  s.add_dependency('json')
  s.requirements << 'cgi'
  s.requirements << 'net/http'
  s.requirements << 'uri'
  s.requirements << 'oauth'

  s.has_rdoc = false
  s.rdoc_options << '--title' << 'PostRank Documentation' <<
                    '--main' << 'README.rdoc' <<
                    '--line-numbers'

  s.files = %w(README.rdoc COPYING lib/postrank.rb lib/postrank/channel.rb lib/postrank/connection.rb lib/postrank/entry.rb lib/postrank/feed.rb lib/postrank/postrank.rb lib/postrank/subscription.rb lib/postrank/user.rb examples/api_example.rb examples/api_example2.rb examples/api_example3.rb examples/simple_example.rb)
end
