RSpec.describe 'email_templates UPDATE' do
  let(:email_template) { create(:email_template) }

  before do
    assume_admin_logged_in
    visit "admin/email_templates/#{email_template.id}/edit"
  end

  context 'when params are valid' do
    it 'updates EmailTemplate' do
      email_template_params = build(:email_template)
      subject = email_template_params.subject
      note = email_template_params.note
      body = email_template_params.body

      fill_in 'Subject',  with: subject
      fill_in 'Note',  with: note
      fill_in 'Body',  with: body

      click_button 'Update Email template'

      expect(page).to have_current_path "/admin/email_templates/#{email_template.id}/edit"
      expect(email_template.reload.subject).to eq(subject)
      expect(email_template.reload.body).to eq(body)
      expect(email_template.reload.note).to eq(note)
    end
  end

  context 'when params are invalid' do
    it 'shows errors' do
      fill_in 'Subject',  with: ''
      fill_in 'Body',  with: ''

      click_button 'Update Email template'

      expect(page).to have_current_path "/admin/email_templates/#{email_template.id}"
      expect_an_error email_template_subject:  :blank
      expect_an_error email_template_body:  :blank
    end
  end

end
