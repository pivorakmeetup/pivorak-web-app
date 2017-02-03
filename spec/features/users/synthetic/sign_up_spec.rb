RSpec.describe 'Synthetic user try to sign up' do
  let!(:synth_user) { create(:user, :synth) }

  before do
    visit '/users/sign_up'
    fill_in 'Email', with: synth_user.email
    click_button 'Sign up'
  end

  it 'sends reset password' do
    active_job = active_jobs[0]
    expect(active_job[:job]).to eq ActionMailer::DeliveryJob
    expect(active_job[:args][0]).to eq 'Devise::Mailer'
    expect(active_job[:args][1]).to eq 'reset_password_instructions'
  end

  it 'redirects to root' do
    expect(page).to have_current_path('/')
  end
end
