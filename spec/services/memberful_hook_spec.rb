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

  describe '#suspended?' do
    it { expect(subject('order.suspended.json')).to be_suspended }
    it { expect(subject('order.purchased.json')).not_to be_suspended }
    it { expect(subject('member_signup.json')).not_to be_suspended }
    it { expect(subject('member_updated.json')).not_to be_suspended }
  end

  describe 'gets the member email address' do
    it { expect(subject('order.suspended.json').email).to eq 'ray.zintoast@example.com' }
    it { expect(subject('order.purchased.json').email).to eq 'john.doe@example.com' }
    it { expect(subject('member_signup.json').email).to eq 'arthur.wrightus@example.com' }
  end
end
