RSpec.describe 'email_template Templates LIST' do
  let!(:email_template) { create(:email_template) }

  before do
    assume_admin_logged_in
    visit "admin/email_templates"
  end

  it { expect(page).to have_content email_template.title }
  it { expect(page).to have_content email_template.note }

end
