require_dependency 'memberful/application_controller'

module Memberful
  class WebHooksController < ApplicationController
    protect_from_forgery if: -> { false } #TODO

    def status
      render json: { version: Memberful::VERSION }
    end

    def create
      @data = JSON.parse(request.body.read)
      @hook = MemberfulHook.new(request.body.read)
      user = find_user_by_memberful_data

      head :ok and return if user.nil?

      if @hook.order?
        badge = Badge.find_by_name('Consumer Defender')

        BadgeGranter.grant(badge, user) if @hook.purchased?

        if @hook.suspended?
          user_badge = UserBadge.find_by(badge_id: badge.id, user_id: user.id)
          BadgeGranter.revoke(user_badge)
        end

      elsif @hook.signup?
        UserCustomField.create!(user_id: user.id, name: 'memberful_id', value: @data['member']['id'])
        user.save
      end

      head :ok
    end

    private

    def find_user_by_memberful_data
      if @hook.order?
        User.find_by_email(@data['order']['member']['email'])
      elsif @hook.signup?
        User.find_by_email(@data['member']['email'])
      end
    end
  end
end
