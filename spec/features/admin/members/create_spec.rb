# frozen_string_literal: true

RSpec.describe 'Members CREATE' do
  before do
    assume_admin_logged_in(supervisor: true)
    visit '/admin/members/new'
  end

  context 'when invalid input' do
    it 'validates presence' do
      fill_in 'Email', with: ''
      click_button 'Create User'

      expect_an_error member_email:      :blank
      expect_an_error member_first_name: :blank
      expect_an_error member_last_name:  :blank
      expect_error_flash_message 'Member', 'created'
    end
  end

  context 'when valid input' do
    it 'create new member' do
      fill_in 'Email',      with: 'tester@example.com'
      fill_in 'First name', with: 'UserFirstName'
      fill_in 'Last name',  with: 'UserLastName'
      click_button 'Create User'

      expect(page).to have_current_path "/admin/members/#{User.last.slug}/edit"
      expect_success_flash_message 'Member', 'created'
      expect(User.last).to be_synthetic
    end
  end
end
