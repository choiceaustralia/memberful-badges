require "rails_helper"

module MemberfulEngine
  class Engine < ::Rails::Engine
    isolate_namespace MemberfulEngine
  end

  Engine.routes.draw do
    resources :widgetts, :only => [:index]
  end

  class WidgettsController < ::ActionController::Base
    def index
    end
  end
end

RSpec.describe MemberfulEngine::WidgettsController, :type => :routing do
  routes { MemberfulEngine::Engine.routes }
  it "routes to the list of all widgets" do
    expect(:get => widgetts_path).
      to route_to(:controller => "memberful_engine/widgetts", :action => "index")
  end
end
