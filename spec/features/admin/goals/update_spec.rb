# frozen_string_literal: true

xdescribe 'Goals UPDATE' do
  let!(:goal)          { create(:goal, title: 'Test Goal') }
  let(:test_edit_path) { '/admin/goals/test-goal/edit' }

  before do
    assume_admin_logged_in
    visit test_edit_path
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Title',  with: ''
      click_button 'Update Goal'

      expect_an_error goal_title: :blank
    end

    it 'validates amount presence' do
      fill_in 'Amount',  with: ''
      click_button 'Update Goal'

      expect_an_error goal_amount: :blank
    end

    it 'validates amount numericality' do
      fill_in 'Amount',  with: 'Some value'
      click_button 'Update Goal'

      expect(page.find('div.ui.red.pointing.above.label.error').text).to eq('is not a number')
    end
  end

  context 'valid input' do
    it 'create new goal' do
      fill_in 'Title',  with: 'Super New Event'
      fill_in 'Amount', with: 100
      click_button 'Update Goal'

      expect(page).to have_current_path '/admin/goals/test-goal/edit'
    end
  end
end
