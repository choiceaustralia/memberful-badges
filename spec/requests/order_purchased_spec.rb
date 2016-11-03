require 'rails_helper'

RSpec.describe 'Memberful Integration', type: :request do
  let(:content_type) { 'application/x-www-form-urlencoded' }
  let(:headers) { { 'CONTENT_TYPE': content_type } }
  let(:event) { 'order.purchased' }

  it 'accepts order.completed hook' do
    raw_data = read_fixture("#{event}.json")
    data = JSON.parse(raw_data)
    post '/memberful/hooks', raw_data, headers
    aggregate_failures do
      expect(request.content_type).to eq content_type
      expect(data['event']).to eq event
      expect(data['order']['member']['email']).to eq 'john.doe@example.com'
      expect(response.status).to eq 201
    end
  end

  it 'accepts other hooks' do
    raw_data = read_fixture('member_signup.json')
    post '/memberful/hooks', raw_data, headers
    expect(response.status).to eq 200
  end
end
