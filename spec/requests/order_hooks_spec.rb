require 'rails_helper'

RSpec.describe 'Memberful Web Hooks Integration', type: :request do
  let(:content_type) { 'application/x-www-form-urlencoded' }
  let(:headers) { { 'CONTENT_TYPE': content_type } }
  let(:user) { double(id: 2) }
  let(:badge) { double(id: 4) }

  describe 'orders' do
    ['order.completed', 'order.suspended', 'order.purchased'].each do |hook|
      it "accepts #{hook} hook" do
        raw_data = read_fixture("#{hook}.json")
        data = JSON.parse(raw_data)

        allow(User).to receive(:find_by_email).and_return(user)
        allow(Badge).to receive(:find_by_name).and_return(badge)

        post '/memberful/hooks', raw_data, headers

        aggregate_failures do
          expect(request.content_type).to eq content_type
          expect(data['event']).to eq hook
          expect(data['order']['member']['email']).to eq 'john.doe@example.com'
          expect(response.status).to eq 200
        end
      end
    end
  end

  ['member_signup', 'member_updated'].each do |hook|
    it "accepts #{hook} hook" do
      allow(User).to receive(:find_by_email).and_return(user)
      raw_data = read_fixture("#{hook}.json")
      post '/memberful/hooks', raw_data, headers
      expect(response.status).to eq 200
    end
  end
end
