# frozen_string_literal: true

RSpec.describe 'Synthetic user try to sign up' do
  let!(:synth_user) { create(:user, :synth) }

  before do
    token = synth_user.send_reset_password_instructions
    visit "/users/password/edit?reset_password_token=#{token}"
    fill_in 'user_password',              with: 'new_password'
    fill_in 'user_password_confirmation', with: 'new_password'
    click_button 'Change my password'
  end

  it 'resirects to root' do
    expect(page).to have_current_path '/'
    expect(page).to have_content 'Your password has been changed successfully. You are now signed in.'
    expect(synth_user.reload).to_not be_synthetic
  end
end
