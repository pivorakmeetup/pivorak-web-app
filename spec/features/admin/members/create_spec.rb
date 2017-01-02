RSpec.describe 'Members CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/members/new'
  end

  context 'invalid input' do
    it 'validates presence' do
      fill_in 'Email',  with: ''
      click_button 'Create User'

      expect_an_error member_email:      :blank
      expect_an_error member_first_name: :blank
      expect_an_error member_last_name:  :blank
    end
  end

  context 'valid input' do
    it 'create new member' do
      fill_in 'Email',      with: 'tester@example.com'
      fill_in 'First name', with: 'UserFirstName'
      fill_in 'Last name',  with: 'UserLastName'
      click_button 'Create User'

      expect(page).to have_current_path '/admin/members'
      expect(page).to have_content 'tester@example.com'
      expect(page).to have_content 'UserFirstName'
      expect(page).to have_content 'UserLastName'
      expect(page).to have_content 'yes'
    end
  end
end
