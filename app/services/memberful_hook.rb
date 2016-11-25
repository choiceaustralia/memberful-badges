
class MemberfulHook
  attr_reader :data

  def initialize(payload)
    @data = JSON.parse(payload)
  end

  def order?
    ['order.purchased', 'order.suspended'].include?(data['event'])
  end
end
