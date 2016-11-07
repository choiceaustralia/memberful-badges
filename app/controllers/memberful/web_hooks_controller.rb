require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      data = JSON.parse(request.body.read)
      user = find_user(data)

      head :ok and return if user.nil?

      if event_order?(data)
        badge = Badge.find_by_name('Consumer Defender')

        BadgeGranter.grant(badge, user) if data['event'] == 'order.purchased'

        if event_revoke?(data)
          user_badge = UserBadge.find_by(badge_id: badge.id, user_id: user.id)
          BadgeGranter.revoke(user_badge)
        end

      elsif event_signup?(data)
        UserCustomField.create!(user_id: user.id, name: 'memberful_id', value: data['member']['id'])
        user.save
      end

      head :ok
    end

    private

    def find_user(data)
      if event_order?(data)
        User.find_by_email(data['order']['member']['email'])
      elsif event_signup?(data)
        User.find_by_email(data['member']['email'])
      end
    end

    def event_order?(data)
      ['order.purchased', 'order.suspended'].include?(data['event'])
    end

    def event_revoke?(data)
      data['event'] == 'order.suspended'
    end

    def event_signup?(data)
      data['event'] == 'member_signup'
    end
  end
end
