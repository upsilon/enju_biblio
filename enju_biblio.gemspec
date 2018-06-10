$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_biblio/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_biblio"
  s.version     = EnjuBiblio::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/next-l/enju_biblio"
  s.summary     = "enju_biblio plugin"
  s.description = "Bibliographic record module for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/{log,private,solr,tmp}/**/*"] - Dir["spec/dummy/db/*.sqlite3"]

  s.add_dependency "enju_library", "~> 0.2.3"
  s.add_dependency "marc"
  s.add_dependency "simple_form"
  s.add_dependency "dynamic_form"
  s.add_dependency "library_stdnums"
  s.add_dependency "lisbn"
  s.add_dependency "faraday"

  s.add_development_dependency "enju_leaf", "~> 1.2.2"
  s.add_development_dependency "enju_manifestation_viewer", "~> 0.2.2"
  s.add_development_dependency "enju_subject", "~> 0.2.3"
  s.add_development_dependency "enju_inventory", "~> 0.2.0"
  s.add_development_dependency "enju_bookmark", "~> 0.2.2"
  s.add_development_dependency "enju_event", "~> 0.2.3"
  s.add_development_dependency "enju_circulation", "~> 0.2.5"
  s.add_development_dependency "enju_ndl", "~> 0.2.3"
  s.add_development_dependency "enju_oai", "~> 0.2.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mysql2", '~> 0.4.10'
  s.add_development_dependency "pg", "~> 0.21"
  s.add_development_dependency "rspec-rails", "~> 3.5"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "vcr", "~> 4.0"
  s.add_development_dependency "sunspot_solr", "2.2.0"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "webmock"
  s.add_development_dependency "sunspot-rails-tester"
  s.add_development_dependency "rspec-activemodel-mocks"
  s.add_development_dependency "resque", "~> 1.27"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "capybara", "~> 3.1.1"
end
