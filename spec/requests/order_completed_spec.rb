require 'rails_helper'

RSpec.describe 'Memberful Integration', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/x-www-form-urlencoded' } }
  let(:data) { {'event' => 'order.completed', 'order' => { 'member' => { 'email' => 'john.doe@example.com'}}} }

  it 'accepts json data' do
    post '/memberful/hooks', data.to_json, headers
    expect(request.content_type).to eq('application/x-www-form-urlencoded')
    expect(data['event']).to eq 'order.completed'
    expect(data['order']['member']['email']).to eq 'john.doe@example.com'
  end
end
