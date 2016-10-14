# name: Memberful Integration
# about: This adds an interface between Memberful and Discourse. It's a bit unconventional.
# version: 0.3.0
# authors: rimian

after_initialize do
  Discourse::Application.routes.append do
    get 'memberful', action: :status, controller: :memberful
    post 'memberful', action: :test, controller: :memberful
  end
end
