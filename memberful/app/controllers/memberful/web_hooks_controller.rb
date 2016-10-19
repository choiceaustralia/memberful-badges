require_dependency "memberful/application_controller"

module Memberful
  class WebHooksController < ApplicationController
    def status
      render json: {version: Memberful::VERSION}
    end
  end
end
