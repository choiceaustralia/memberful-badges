Memberful::Engine.routes.draw do
  get '/foo', controller: :foobar, action: :index
  get '/status', controller: :web_hooks, action: :status
end
