# name: Memberful Integration
# about: This adds an interface between Memberful and Discourse. It's a bit unconventional.
# version: 0.4.1
# authors: rimian

after_initialize do
  Discourse::Application.routes.append do
    namespace :memberful, defaults: { :format => 'json' } do
      get 'status', action: :status, controller: 'memberful'
      post 'memberful', action: :test, controller: :memberful
    end
  end
end
