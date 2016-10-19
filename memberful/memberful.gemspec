$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "memberful/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "memberful"
  s.version     = Memberful::VERSION
  s.authors     = ["Rimian Perkins"]
  s.email       = ["hello@rimian.com.au"]
  s.homepage    = "https://github.com/choiceaustralia/memberful-integration"
  s.summary     = "A rails engine for memberful integration with discourse"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
