RSpec.describe 'Synthetic user new password' do
  let!(:synth_user) { create(:user, :synth, confirmation_token: 'super_token') }

  it 'user become real' do
    visit "/users/password/edit?reset_password_token=super_token"

    synth_user.reload
    expect(synth_user).not_to be_synthetic
  end
end
