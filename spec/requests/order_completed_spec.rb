require 'rails_helper'

RSpec.describe 'Memberful Integration', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/x-www-form-urlencoded' } }

  it 'accepts order.completed hook' do
    raw_data = read_fixture('order.completed.json')
    data = JSON.parse(raw_data)
    post '/memberful/hooks', raw_data, headers
    aggregate_failures do
      expect(request.content_type).to eq('application/x-www-form-urlencoded')
      expect(data['event']).to eq 'order.completed'
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
