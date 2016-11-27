require 'rails_helper'

module Memberful
  RSpec.describe WebHooksController, type: :controller do
    routes { Memberful::Engine.routes }

    describe 'web hooks' do
      let(:headers) { { 'CONTENT_TYPE': 'application/x-www-form-urlencoded' } }
      let(:user) { double(id: 2, save: nil) }
      let(:badge) { double(id: 4) }

      describe 'non community member users' do
        before { allow(User).to receive(:find_by_email).and_return(nil) }

        it 'ignores non users for member signup' do
          expect(UserCustomField).not_to receive(:create!)
          expect(User).not_to receive(:save)
          post :create, read_fixture('member_signup.json'), headers
        end

        it 'ignores non users for orders' do
          expect(Badge).not_to receive(:find_by_name)
          post :create, read_fixture('order.purchased.json'), headers
        end
      end

      describe 'save memberful ID' do
        let(:data) { read_fixture('member_signup.json') }

        after { post :create, data, headers }

        it 'finds the user' do
          allow(UserCustomField).to receive(:create!)
          expect(User).to receive(:find_by_email).with('arthur.wrightus@example.com').and_return(user)
        end

        it 'creates a custom field' do
          allow(User).to receive(:find_by_email).and_return(user)
          expect(UserCustomField).to receive(:create!).with(user_id: user.id, name: 'memberful_id', value: 752)
        end
      end

      describe 'grant user a badge' do
        let(:data) { read_fixture('order.purchased.json') }

        after { post :create, data, headers }

        it 'finds the user' do
          expect(User).to receive(:find_by_email).with('john.doe@example.com')
        end

        it 'finds the badge' do
          allow(User).to receive(:find_by_email).and_return(user)
          expect(Badge).to receive(:find_by_name).with('Consumer Defender')
        end

        it 'grants the badge to the user' do
          allow(User).to receive(:find_by_email).and_return(user)
          allow(Badge).to receive(:find_by_name).and_return(badge)
          expect(BadgeGranter).to receive(:grant).with(badge, user)
        end
      end

      describe 'revoking a badge' do
        let(:data) { read_fixture('order.suspended.json') }

        after { post :create, data, headers }

        it 'revokes the badge from the user' do
          allow(User).to receive(:find_by_email).and_return(user)
          allow(Badge).to receive(:find_by_name).and_return(badge)
          expect(UserBadge).to receive(:find_by).with(badge_id: badge.id, user_id: user.id)
        end
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
