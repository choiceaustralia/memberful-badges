require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      data = JSON.parse(request.body.read)
      if data['event'] == 'order.completed'
        user = User.find_by_email(data['order']['member']['email'])
        badge = Badge.find_by_name('Consumer Defender')
        BadgeGranter.grant(badge, user)
        head :created
      end
    end
  end
end
