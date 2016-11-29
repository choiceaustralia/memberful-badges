require 'rails_helper'

RSpec.describe 'Memberful Web Hooks Integration', type: :request do
  let(:content_type) { 'application/x-www-form-urlencoded' }
  let(:headers) { { 'CONTENT_TYPE' => content_type, 'HTTP_X_MEMBERFUL_WEBHOOK_DIGEST' => 'ce03efd9a0c4441a582dcdfe7f33f47f057a61f6ed8a8fbd05a52276c4c9bb1a' } }
  let(:user) { double(id: 2, save: nil) }
  let(:badge) { double(id: 4) }

  it 'responds to signup' do
    payload = read_fixture('member_signup.json')
    post '/memberful/hooks', payload, headers
    expect(response.status).to eq 200
  end
end
