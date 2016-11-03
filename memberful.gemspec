$:.push File.expand_path("../lib", __FILE__)

require 'memberful/version'

Gem::Specification.new do |s|
  s.name        = 'memberful'
  s.version     = Memberful::VERSION
  s.authors     = ['Rimian Perkins']
  s.email       = ['hello@rimian.com.au']
  s.homepage    = "https://github.com/choiceaustralia/memberful-integration"
  s.summary     = "A rails engine for memberful integration with discourse"
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'shoulda-matchers'
end
