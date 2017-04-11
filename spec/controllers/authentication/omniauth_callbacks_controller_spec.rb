RSpec.describe Authentication::OmniauthCallbacksController do
  include Devise::Test::ControllerHelpers

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  Devise.omniauth_providers.each do |provider|
    describe "##{provider}" do
      context 'with valid params' do
        before { request.env['omniauth.auth'] = build(:omniauth_params) }

        it 'creates a user' do
          post provider
          expect(::Authentication::User.count).to eq 1
        end

        it 'signs in a user' do
          expect(subject.current_user).to be_nil
          post provider
          expect(subject.current_user).not_to be_nil
        end

        it 'redirects to the homepage' do
          post provider
          expect(response).to redirect_to root_url
        end
      end
    end

    context 'with invalid params' do
      before { request.env['omniauth.auth'] = {} }

      it "doesn't create a user" do
        post provider
        expect(::User.count).to eq 0
      end

      it 'redirects to sign up page' do
        post provider
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end

