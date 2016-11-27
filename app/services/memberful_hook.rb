
class MemberfulHook
  attr_reader :data

  def initialize(payload)
    @data = JSON.parse(payload)
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
    order? ? data['order']['member']['email'] : data['member']['email']
  end

  private

  def event
    data['event']
  end
end
