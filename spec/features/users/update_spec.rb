# frozen_string_literal: true

RSpec.describe 'User Update' do
  let(:user) { create(:user) }

  before do
    assume_logged_in(user)
    visit '/users/edit'
  end

  it 'updates user profile' do
    fill_in 'user_email',            with: user.email
    fill_in 'user_current_password', with: user.password
    uncheck 'user_subscribed'

    click_button 'Update'

    expect(user.reload.subscribed).to eq false
  end
end
