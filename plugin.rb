# name: Memberful Integration
# about: This adds an interface between Memberful and Discourse. It's a bit of a hack.
# version: 0.1.0
# authors: rimian

after_initialize do
  Discourse::Application.routes.append do
    get 'memberful': 'memberful#test'
  end
end
