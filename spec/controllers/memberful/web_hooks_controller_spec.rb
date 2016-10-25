require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    describe 'create' do
      let(:user) { double(name: "Ray Zintoast") }

      it 'permits some params' do
        allow(User).to receive(:find_by_email).and_return(user)
        expect(described_class).to permit(:event, { order: [ :member ] }).for(:create)
      end

       it 'works with find_by' do
         expect(User).to receive(:find_by_email).and_return(user)
         post :create
       end
    end

    it 'gives the user a badge' do
      skip
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
