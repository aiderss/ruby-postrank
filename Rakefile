require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

spec = eval(File.read(File.join(File.dirname(__FILE__), "postrank.gemspec")))

task :default => :gem

desc 'Generate RDoc documentation for PostRank'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'COPYING', 'lib/**/*.rb')
  rdoc.main = 'README.rdoc'
  rdoc.title = 'PostRank Documentation'

  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--line-numbers'
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

