require "rails_helper"

module Memberful
  RSpec.describe FoobarController, type: :routing do
    routes { Memberful::Engine.routes }

    it "has routes" do
      expect(:get => '/foo').to route_to(:controller => "memberful/foobar", :action => "index")
    end

    it "has a status route" do
      expect(:get => '/status').to route_to(:controller => "memberful/web_hooks", :action => "status")
    end
  end
end
