RSpec.describe 'Synthetic user try to sign up' do
  let!(:synth_user) { create(:user, :synth) }

  before do
    visit '/users/sign_up'
    fill_in 'Email', with: 'synth@example.com'
    click_button 'Sign up'
  end

  it 'redirects to the page of new password for synthetic user' do
    expect(page).to have_current_path '/users/password/new?synthetic=synth%40example.com'
    expect(page).to have_content 'Hello Synth User, we know You!'
    expect(page).to have_content 'We already created account for you'
    expect(page).to have_link 'Get account control'
  end

  it 'process password reset' do
    click_link 'Get account control'

    expect(page).to have_current_path '/users/sign_in'
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end
end
