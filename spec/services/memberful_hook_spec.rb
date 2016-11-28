require 'rails_helper'

RSpec.describe MemberfulHook do

  describe '#valid?' do
    let(:request) do
      double(
        body: double(read: read_fixture('member_signup.json')),
        headers: { 'X-Memberful-Webhook-Digest' => 'e705c95c8c076f72dedd4ff54a56fdc4fce05d10f9b7ec7fc183ddfa948857e6' }
      )
    end

    it 'is a valid request' do
      expect(described_class.new(request, 'secret')).to be_valid
    end

    it 'is not a valid request' do
      expect(described_class.new(request, 'wrong!')).not_to be_valid
    end
  end

  describe 'valid hooks' do
    def subject(fixture)
      request = double(body: double(read: read_fixture(fixture)))
      described_class.new(request, ENV['secret'])
    end

    describe '#order?' do
      it { expect(subject('order.completed.json')).to be_order }
      it { expect(subject('order.purchased.json')).to be_order }
      it { expect(subject('order.refunded.json')).to be_order }
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

    describe 'gets the member id' do
      it { expect(subject('order.suspended.json').memberful_id).to eq 23 }
      it { expect(subject('order.refunded.json').memberful_id).to eq 232 }
      it { expect(subject('member_signup.json').memberful_id).to eq 752 }
      it { expect(subject('member_updated.json').memberful_id).to eq 11 }
    end
  end
end
