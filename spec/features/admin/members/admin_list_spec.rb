RSpec.describe 'Members LIST' do
  let!(:user)  { create(:user, :admin) }
  let!(:user2) { create(:user, first_name: 'Not', last_name: 'Admin') }

  before do
    assume_admin_logged_in(user)
    visit '/admin/members'
  end

  it 'disaplays message with admins full names' do
    expect(find('.warning.message')).to have_content user.full_name
    expect(find('.warning.message')).to_not have_content user2.full_name
  end
end
