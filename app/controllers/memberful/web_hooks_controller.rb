require_dependency "memberful/application_controller"

module Memberful
  class WebHooksController < ApplicationController
    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      params.permit(:event, order: [:member])
      user = User.find_by_email('test@example.com.au')
      # badge = ::Badge.find_by_name("Basic User")
      # BadgeGranter.grant(badge, user)
      head :created
    end
  end
end
