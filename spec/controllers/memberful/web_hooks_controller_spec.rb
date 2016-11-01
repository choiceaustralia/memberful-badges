require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    describe 'create' do
      let(:data) { File.read('./spec/fixtures/order.completed.json') }
      let(:headers) { { 'CONTENT_TYPE': 'application/x-www-form-urlencoded' } }
      let(:user) { double }
      let(:badge) { double }

      after { post :create, data, headers }

      it 'finds the user' do
        expect(User).to receive(:find_by_email).with('john.doe@example.com')
      end

      it 'finds the badge' do
        expect(Badge).to receive(:find_by_name).with('Consumer Defender')
      end

      it 'grants the badge to the user' do
        allow(User).to receive(:find_by_email).and_return(user)
        allow(Badge).to receive(:find_by_name).and_return(badge)
        expect(BadgeGranter).to receive(:grant).with(badge, user)
      end
    end

    describe '/status' do
      before { get :status }

      it 'is successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'has a version' do
        expect(JSON.parse(response.body)).to eq({ 'version' => Memberful::VERSION })
      end
    end
  end
end
