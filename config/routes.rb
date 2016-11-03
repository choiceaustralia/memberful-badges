Memberful::Engine.routes.draw do
  get '/status', controller: :web_hooks, action: :status
  post '/hooks', controller: :web_hooks, action: :create
end
