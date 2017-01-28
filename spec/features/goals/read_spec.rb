#
# Skip until 1.1 version
#
# RSpec.describe 'Goals READ' do
#   let!(:goal_a) { create(:goal, title: 'Test Goal A') }
#   let!(:goal_b) { create(:goal, title: 'Test Goal B') }

#   before do
#     assume_logged_in
#     visit '/goals'
#   end

#   it { expect(page).to have_link 'Test Goal A' }
#   it { expect(page).to have_link 'Test Goal B' }

#   it 'click on goal redirects to #show' do
#     click_link 'Test Goal A'
#     expect(page).to have_current_path('/goals/test-goal-a')
#   end
# end
