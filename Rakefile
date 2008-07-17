require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/gempackagetask'

spec = eval(File.read(File.join(File.dirname(__FILE__), "postrank.gemspec")))

desc 'Default: run unit tests'
task :default => :test

desc 'Generate RDoc documentation for PostRank'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'COPYING', 'lib/**/*.rb')
  rdoc.main = 'README.rdoc'
  rdoc.title = 'PostRank Documentation'

  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--line-numbers'
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

