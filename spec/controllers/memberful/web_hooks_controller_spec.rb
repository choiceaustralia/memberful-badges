require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    describe 'create' do
      let(:user) { double }
      let(:params) { JSON.parse(File.read('./spec/fixtures/order.completed.json')) }

      it 'permits some params' do
        allow(User).to receive(:find_by_email)
        expect(described_class).to permit(:event, { order: [ :member ] }).for(:create, params: params)
      end

      it 'works with find_by' do
        expect(User).to receive(:find_by_email).with('john.doe@example.com').and_return(user)
        post :create, params
      end
    end

    it 'gives the user a badge' do
      post :create, { event: 'order.completed', order: { member: { email: 'doogie@example.com' } } }
      expect(::User).to be_truthy
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
