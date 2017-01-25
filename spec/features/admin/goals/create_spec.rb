RSpec.describe 'Goals CREATE' do
  before do
    assume_admin_logged_in
    visit '/admin/goals/new'
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Title',  with: ''
      click_button 'Create Goal'

      expect_an_error goal_title: :blank
    end

    it 'validates amount presence' do
      fill_in 'Amount',  with: ''
      click_button 'Create Goal'

      expect_an_error goal_amount: :blank
    end

    it 'validates amount numericality' do
      fill_in 'Amount',  with: 'Some value'
      click_button 'Create Goal'

      expect_an_error goal_amount: :numericality
    end
  end

  context 'valid input' do
    it 'create new event' do
      fill_in 'Title',  with: 'Super New Goal'
      fill_in 'Amount', with: 1000
      click_button 'Create Goal'

      expect(page).to have_current_path '/admin/goals/super-new-goal/edit'
    end
  end
end
