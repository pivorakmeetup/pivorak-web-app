RSpec.describe 'Emails CREATE' do

  before do
    assume_admin_logged_in
    visit "admin/emails/new"
  end

  context 'when params are valid' do
    it 'creates Email' do
      email = build(:email)
      subject = email.subject
      body = email.body

      fill_in 'Subject',  with: subject
      fill_in 'Body',  with: body

      click_button 'Create Email'

      expect(page).to have_current_path "/admin/emails/#{Email.last.id}"
      expect(page).to have_content(subject)
      expect(page).to have_content(body)
    end
  end

  context 'when params are invalid' do
    it 'creates Email' do
      fill_in 'Subject',  with: ''
      fill_in 'Body',  with: ''

      click_button 'Create Email'

      expect(page).to have_current_path "/admin/emails"
      expect_an_error email_subject:  :blank
      expect_an_error email_body:  :blank
    end
  end

end
