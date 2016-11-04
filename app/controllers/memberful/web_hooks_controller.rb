require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      data = JSON.parse(request.body.read)

      if event_actionable?(data)
        user = User.find_by_email(data['order']['member']['email'])
        badge = Badge.find_by_name('Consumer Defender')

        BadgeGranter.grant(badge, user) if data['event'] == 'order.purchased'

        if data['event'] == 'order.suspended'
          user_badge = UserBadge.find_by(badge_id: badge.id, user_id: user.id)
          BadgeGranter.revoke(user_badge)
        end
      end

      head :ok
    end

    private

    def event_actionable?(data)
      ['order.purchased', 'order.suspended'].include?(data['event'])
    end
  end
end
