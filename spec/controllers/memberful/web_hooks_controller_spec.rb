require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    it 'permits some params' do
      expect(described_class).to permit(:event, { :member=>[ :id, :email ] }).for(:create)
    end

    describe 'order completed web hook' do
      before { post :create }

      it 'is successful' do
        expect(response).to have_http_status(:created)
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
