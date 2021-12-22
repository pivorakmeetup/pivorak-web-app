# frozen_string_literal: true

RSpec.describe 'Profile UPDATE' do
  context 'when user is not logged in' do
    before do
      visit '/profile/edit'
    end

    it 'responds with redirect' do
      expect(page).to have_current_path '/users/sign_in'
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user, :tester) }

    before do
      assume_logged_in(user)
      visit '/profile/edit'
    end

    context 'with invalid input' do
      context 'when updating profile attrs' do
        it 'validates errors' do
          fill_in 'Email', with: ''
          click_button 'Update'

          expect(page).to have_content I18n.t('members.failure')
        end
      end

      context 'when updating password' do
        it 'validates errors' do
          fill_in 'Password', with: '123'
          fill_in 'Password confirmation', with: '1234'

          click_button 'Update'

          expect(page).to have_content I18n.t('members.failure')
        end
      end
    end

    context 'with valid input' do
      context 'when updates profile attrs' do
        it 'updates user', :aggregate_failures do
          email = Faker::Internet.email
          first_name = Faker::Name.name
          last_name = Faker::Name.name
          old_slug = user.slug

          fill_in 'Email', with: email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name

          click_button 'Update'

          expect(page).to have_content I18n.t('members.success')

          expect(user.reload.email).to eq(email)
          expect(user.reload.first_name).to eq(first_name)
          expect(user.reload.last_name).to eq(last_name)
          expect(user.reload.slug).not_to eq(old_slug)
        end
      end

      context 'when updating password' do
        it 'updates user' do
          password = user.password

          fill_in 'Password', with: password
          fill_in 'Password confirmation', with: password

          click_button 'Update'

          expect(page).to have_content I18n.t('members.success')
        end
      end
    end
  end
end
