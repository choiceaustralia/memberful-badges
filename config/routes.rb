Memberful::Engine.routes.draw do
  get '/status', controller: :web_hooks, action: :status
end
