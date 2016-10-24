require_dependency "memberful/application_controller"

module Memberful
  class WebHooksController < ApplicationController
    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      params.permit(:event, member: [:id, :email])
      head :created
    end
  end
end
