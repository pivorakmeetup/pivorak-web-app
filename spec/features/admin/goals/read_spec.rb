RSpec.describe 'Goals READ' do
  let!(:goal_a) { create(:goal, title: 'Test Goal A') }
  let!(:goal_b) { create(:goal, title: 'Test Goal B') }

  before do
    assume_admin_logged_in
    visit '/admin/goals'
  end

  it { expect(page).to have_content 'Test Goal A' }
  it { expect(page).to have_content 'Test Goal B' }
  it { expect(page).to have_link 'New Goal' }
  it { expect(page).to have_link('Edit', count: 2) }
  it 'New Goal click redirect to #new' do
    click_link 'New Goal'
    expect(page).to have_current_path('/admin/goals/new')
  end
end
