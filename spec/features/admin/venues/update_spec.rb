RSpec.describe 'Venues UPDATE' do
  let!(:venue)         { create(:venue, name: 'Test Venue') }
  let(:test_edit_path) { '/admin/venues/test-venue/edit' }

  before do
    assume_admin_logged_in
    visit test_edit_path
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Name',  with: ''
      click_button 'Update Venue'

      expect_an_error venue_name:  :blank
    end
  end

  context 'valid input' do
    it 'create new venue' do
      fill_in 'Name',  with: 'Secret New Venue'
      click_button 'Update Venue'

      expect(page).to have_current_path '/venues/test-venue'
    end
  end
end