# name: Memberful Integration
# about: This adds an interface between Memberful and Discourse. It's a bit unconventional.
# version: 0.5.1
# authors: rimian

after_initialize do
  Discourse::Application.routes.append do
    namespace :memberful, defaults: { format: 'json' } do
      get 'status', action: :status, controller: :memberful
      post 'memberful', action: :hooks, controller: :memberful
    end
  end
end
