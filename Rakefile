require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = %q{postrank}
  s.version = "0.0.1"
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
                    '--main' << 'README' <<
                    '--line-numbers'

  s.files = [ "README", "COPYING" ] + Dir['lib/**/*.rb'] + Dir['examples/**/*.rb']

  s.test_files = Dir['test/**/test_*.rb']
end

desc 'Default: run unit tests'
task :default => :test

desc 'Generate RDoc documentation for PostRank'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README', 'COPYING', 'lib/**/*.rb')
  rdoc.main = 'README'
  rdoc.title = 'PostRank Documentation'

  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--title' << 'PostRank' <<
                  '--main' << 'README' <<
                  '--line-numbers'
end

desc 'Test the PostRank gem'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.libs << 'test'
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

