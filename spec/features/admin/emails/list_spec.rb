RSpec.describe 'Emails LIST' do
  let!(:email) { create(:email) }

  before do
    assume_admin_logged_in
    visit "admin/emails"
  end

  it { expect(page).to have_content email.subject }

end
