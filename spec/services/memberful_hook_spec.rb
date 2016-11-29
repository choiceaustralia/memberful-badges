require 'rails_helper'

RSpec.describe MemberfulHook do

  describe '#valid?' do
    let(:payload) { read_fixture('member_signup.json') }

    it 'is a valid request' do
      ENV['DISCOURSE_MEMBERFUL_WEBHOOK_SECRET'] = 'secret'
      expect(described_class.valid_secret?(payload, 'ce03efd9a0c4441a582dcdfe7f33f47f057a61f6ed8a8fbd05a52276c4c9bb1a')).to eq true
    end

    it 'is not a valid request' do
      ENV['DISCOURSE_MEMBERFUL_WEBHOOK_SECRET'] = 'wrong-secret'
      expect(described_class.valid_secret?(payload, 'ce03efd9a0c4441a582dcdfe7f33f47f057a61f6ed8a8fbd05a52276c4c9bb1a')).to eq false
    end
  end

  describe 'valid hooks' do
    def subject(fixture)
      described_class.new(read_fixture(fixture))
    end

    describe '.order?' do
      it { expect(subject('order.completed.json')).to be_order }
      it { expect(subject('order.purchased.json')).to be_order }
      it { expect(subject('order.refunded.json')).to be_order }
      it { expect(subject('order.suspended.json')).to be_order }
      it { expect(subject('member_updated.json')).not_to be_order }
      it { expect(subject('member_signup.json')).not_to be_order }
    end

    describe '.purchased?' do
      it { expect(subject('order.purchased.json')).to be_purchased }
      it { expect(subject('order.suspended.json')).not_to be_purchased }
      it { expect(subject('member_updated.json')).not_to be_purchased }
      it { expect(subject('member_signup.json')).not_to be_purchased }
    end

    describe '.signup?' do
      it { expect(subject('member_signup.json')).to be_signup }
      it { expect(subject('member_updated.json')).not_to be_signup }
    end

    describe '.suspended?' do
      it { expect(subject('order.suspended.json')).to be_suspended }
      it { expect(subject('order.purchased.json')).not_to be_suspended }
      it { expect(subject('member_signup.json')).not_to be_suspended }
      it { expect(subject('member_updated.json')).not_to be_suspended }
    end

    describe 'gets the member email address' do
      it { expect(subject('order.suspended.json').email).to eq 'ray.zintoast@example.com' }
      it { expect(subject('order.purchased.json').email).to eq 'arthur.wrightus@example.com' }
      it { expect(subject('member_signup.json').email).to eq 'john.doe@example.com' }
    end

    describe 'gets the member id' do
      it { expect(subject('order.suspended.json').memberful_id).to eq 23 }
      it { expect(subject('order.refunded.json').memberful_id).to eq 232 }
      it { expect(subject('member_updated.json').memberful_id).to eq 11 }
    end
  end
end
