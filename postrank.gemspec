require 'rake'

Gem::Specification.new do |s|
   s.name = %q{postrank}
   s.version = "0.0.1"
   s.authors = ["dan sinclair"]
   s.email = %q{dj2@everburning.com}
   s.summary = %q{PostRank provides simple wrapper around the PostRank.com API.}
   s.homepage = %q{http://http://github.com/dj2/ruby-postrank/wikis/}
   s.description = %q{PostRank provides a simple wrapper around the PostRank.com API.}
   s.has_rdoc = true
   s.rdoc_options << '--title' << 'PostRank Documentation' <<
                     '--main' << 'README' <<
                     '--line-numbers'
   s.add_dependency('')
   s.files = [ "README", "COPYING" ]
   s.files << FileList['lib/**/*.rb', 'test/**/*'].to_a
   s.test_files = FileList['test/**/*_test.rb'].to_a
end
