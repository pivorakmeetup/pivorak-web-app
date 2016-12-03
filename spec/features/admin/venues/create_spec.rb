RSpec.describe 'Events CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/venues/new'
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Name',  with: ''
      click_button 'Create Venue'

      expect_an_error venue_name:  :blank
    end
  end

  context 'valid input' do
    it 'create new venue' do
      fill_in 'Name',  with: 'Secret New Venue'
      fill_in 'Address',  with: 'Some Place'
      fill_in 'Maps url',  with: 'https://goo.gl/maps/LkLW5YkNzNL2'
      click_button 'Create Venue'

      expect(page).to have_current_path '/venues/secret-new-venue'
    end
  end
end