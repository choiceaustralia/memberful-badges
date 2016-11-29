require 'digest'

class MemberfulHook
  attr_reader :data

  def initialize(payload)
    @data = JSON.parse(payload)
  end

  def self.valid_secret?(payload, hash)
    Digest::SHA256.hexdigest(payload.strip + ENV['DISCOURSE_MEMBERFUL_WEBHOOK_SECRET']) == hash
  end

  def order?
    %r{^order\.}.match(event).present?
  end

  def purchased?
    event == 'order.purchased'
  end

  def suspended?
    event == 'order.suspended'
  end

  def signup?
    event == 'member_signup'
  end

  def email
    member['email']
  end

  def memberful_id
    member['id']
  end

  private

  def member
    order? ? data['order']['member'] : data['member']
  end

  def event
    data['event']
  end
end
