require "rails_helper"

module Memberful
  RSpec.describe WebHooksController, type: :routing do
    routes { Memberful::Engine.routes }

    it "has a status route" do
      expect(:get => '/status').to route_to(:controller => "memberful/web_hooks", :action => "status")
    end
  end
end
