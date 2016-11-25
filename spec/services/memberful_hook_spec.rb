require 'rails_helper'

RSpec.describe MemberfulHook do

  def subject(fixture)
    described_class.new(read_fixture(fixture))
  end

  it { expect(subject('order.purchased.json')).to be_order }
  it { expect(subject('order.suspended.json')).to be_order }
  it { expect(subject('member_updated.json')).not_to be_order }
  it { expect(subject('member_signup.json')).not_to be_order }
end
