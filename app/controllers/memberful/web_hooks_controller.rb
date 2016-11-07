require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      data = JSON.parse(request.body.read)

      if event_order?(data)
        user = User.find_by_email(data['order']['member']['email'])
        badge = Badge.find_by_name('Consumer Defender')

        BadgeGranter.grant(badge, user) if data['event'] == 'order.purchased'

        if event_revoke?(data)
          user_badge = UserBadge.find_by(badge_id: badge.id, user_id: user.id)
          BadgeGranter.revoke(user_badge)
        end

      elsif event_signup?(data)
        user = User.find_by_email(data['member']['email'])
        unless user.nil?
          UserCustomField.create!(user_id: user.id, name: 'memberful_id', value: data['member']['id'])
          user.save
        end
      end

      head :ok
    end

    private

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
