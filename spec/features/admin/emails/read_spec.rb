RSpec.describe 'Emails READ' do
  let!(:email) { create(:email) }

  before do
    assume_admin_logged_in
    visit "admin/emails"
    click_on email.subject
  end

  it { expect(page).to have_content email.subject }
  it { expect(page).to have_content email.body }

end
