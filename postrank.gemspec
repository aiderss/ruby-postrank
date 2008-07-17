Gem::Specification.new do |s|
  s.name = %q{postrank}
  s.version = "0.0.2"
  s.authors = ["dan sinclair"]
  s.email = %q{dj2@everburning.com}
  s.homepage = %q{http://http://github.com/dj2/ruby-postrank/wikis/}

  s.summary = %q{PostRank provides simple wrapper around the PostRank.com API.}
  s.description = %q{PostRank provides a simple wrapper around the PostRank.com API.}

  s.add_dependency('json')
  s.requirements << 'cgi'
  s.requirements << 'uri'
  s.requirements << 'net/http'

  s.has_rdoc = true
  s.rdoc_options << '--title' << 'PostRank Documentation' <<
                    '--main' << 'README.rdoc' <<
                    '--line-numbers'

  s.files = %w(README.rdoc COPYING lib/postrank.rb lib/postrank/server.rb lib/postrank/feed.rb lib/postrank/entry.rb examples/api_example.rb examples/api_example2.rb examples/simple_example.rb)

  s.test_files = %w(test/test_server.rb test/test_feed.rb)
end
