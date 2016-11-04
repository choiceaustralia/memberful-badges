require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      data = JSON.parse(request.body.read)
      if actionable_event?(data)
        user = User.find_by_email(data['order']['member']['email'])
        badge = Badge.find_by_name('Consumer Defender')
        BadgeGranter.grant(badge, user)
        head :created
      else
        head :ok
      end
    end

    private

    def actionable_event?(data)
      data['event'] == 'order.purchased'
    end
  end
end
