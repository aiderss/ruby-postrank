require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'

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

