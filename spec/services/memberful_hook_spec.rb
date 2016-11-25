require 'rails_helper'

RSpec.describe MemberfulHook do

  def subject(fixture)
    described_class.new(read_fixture(fixture))
  end

  describe '#order?' do
    it { expect(subject('order.purchased.json')).to be_order }
    it { expect(subject('order.suspended.json')).to be_order }
    it { expect(subject('member_updated.json')).not_to be_order }
    it { expect(subject('member_signup.json')).not_to be_order }
  end

  describe '#purchased?' do
    it { expect(subject('order.purchased.json')).to be_purchased }
    it { expect(subject('order.suspended.json')).not_to be_purchased }
    it { expect(subject('member_updated.json')).not_to be_purchased }
    it { expect(subject('member_signup.json')).not_to be_purchased }
  end

  describe '#signup?' do
    it { expect(subject('member_signup.json')).to be_signup }
    it { expect(subject('member_updated.json')).not_to be_signup }
  end
end
