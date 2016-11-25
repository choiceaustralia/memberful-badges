
class MemberfulHook
  attr_reader :data

  def initialize(payload)
    @data = JSON.parse(payload)
  end

  def order?
    ['order.purchased', 'order.suspended'].include?(event)
  end

  def purchased?
    event == 'order.purchased'
  end

  def signup?
    event == 'member_signup'
  end

  private

  def event
    data['event']
  end
end
