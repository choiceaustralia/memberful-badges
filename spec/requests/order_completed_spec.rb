require 'rails_helper'

RSpec.describe 'Memberful Integration', type: :request do
  let(:headers) { { 'CONTENT_TYPE': 'application/x-www-form-urlencoded' } }
  let(:raw_data) { File.read('./spec/fixtures/order.completed.json') }
  let(:data) { JSON.parse(raw_data) }

  it 'accepts json data' do
    post '/memberful/hooks', raw_data, headers
    expect(request.content_type).to eq('application/x-www-form-urlencoded')
    expect(data['event']).to eq 'order.completed'
    expect(data['order']['member']['email']).to eq 'john.doe@example.com'
  end
end
