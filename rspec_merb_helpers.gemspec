GEM_NAME = "rspec_merb_helpers"
GEM_VERSION = "0.0.1"

Gem::Specification.new do |s| 
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.author = "Laurynas Liutkus"
  s.email = "laurynasl@gmail.com"
  s.homepage = "http://github.com/laurynasl/rspec_merb_helpers/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Helper methods for testing MERB applications"
  s.files = [
    "lib/rspec_merb_helpers.rb",
    "README"
  ]
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = [
  ]
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.add_dependency("rspec", ">= 1.1.4")
  s.add_dependency("merb", ">= 0.9.9")
end
