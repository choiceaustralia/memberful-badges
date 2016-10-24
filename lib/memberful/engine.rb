# require dependencies declared in your gemspec
# Gem.loaded_specs['memberful'].dependencies.each do |d|
#   require d.name
# end

module Memberful
  class Engine < ::Rails::Engine
    isolate_namespace Memberful

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
