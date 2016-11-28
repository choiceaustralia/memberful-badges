
class MemberfulHook
  attr_reader :data, :secret

  def initialize(payload, secret)
    @data = JSON.parse(payload)
  end

  def valid?
    true
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
