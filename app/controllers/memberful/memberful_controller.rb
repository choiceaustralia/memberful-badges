# This belongs to https://github.com/choiceaustralia/memberful-badges
# It is copied into app/controllers from plugins/memberful

class Memberful::MemberfulController < ApplicationController
  protect_from_forgery unless: -> { true } # TODO

  def status
    version = Plugin::Metadata.parse(File.open('plugins/memberful/plugin.rb', 'r')).version
    render json: { version: version }
  end

  def hooks
    user = User.find_by_email(memberful_params['member']['email'])
    user.custom_fields['memberful_id'] = memberful_params['member']['id']
    user.save
    render json: memberful_params
  end

  private

  def memberful_params
    params.permit(:event, member: [:id, :email])
  end
end
