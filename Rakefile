require 'rubygems'
require 'rake'
require "rake/gempackagetask"

spec = eval(IO.read('rspec_merb_helpers.gemspec'))

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

desc "Run :package and install the resulting .gem"
task :install => :package do
  sh %{sudo gem install pkg/#{GEM_NAME}-#{GEM_VERSION} --no-update-sources}
end
