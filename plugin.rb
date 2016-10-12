# name: Memberful
# about: testing
# version: 0.1.0
# authors: rimian

after_initialize do
  SessionController.class_eval do
    def route_redirect
      redirect_to "/"
    end
  end

  Discourse::Application.routes.append do
    get "testing" => "session#route_redirect"
  end
end
