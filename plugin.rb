# name: memberful-integration
# about: Integrating Discourse with Stripe
# version: 0.1.0
# authors: Rimian Perkins

require File.expand_path('../lib/memberful/engine', __FILE__)

after_initialize do
  Discourse::Application.routes.prepend do
    mount ::Memberful::Engine, at: '/memberful'
  end
end
