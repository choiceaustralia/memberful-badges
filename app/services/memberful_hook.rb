require 'digest'

class MemberfulHook
  attr_reader :request, :data, :secret

  def initialize(request, secret)
    @request = request
    @data = JSON.parse(request.body.read)
    @secret = secret
  end

  def valid?
    Digest::SHA256.hexdigest(@request.body.read + @secret) == request.headers['X-Memberful-Webhook-Digest']
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
