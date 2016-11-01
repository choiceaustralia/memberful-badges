require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    describe 'create' do
      let(:params) { JSON.parse(File.read('./spec/fixtures/order.completed.json')) }

      it 'finds the user' do
        allow(JSON).to receive(:parse).and_return(params)
        expect(User).to receive(:find_by_email).with('john.doe@example.com')
        post :create
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
