# frozen_string_literal: true

RSpec.describe 'Members LIST' do
  let!(:supervisor) { create(:user, :supervisor) }
  let!(:not_admin) { create(:user, first_name: 'Not', last_name: 'Admin') }

  before do
    assume_admin_logged_in(supervisor)
    visit '/admin/members'
  end

  it 'disaplays message with admins full names', :aggregate_failures do
    expect(find('.warning.message')).to have_content supervisor.full_name
    expect(find('.warning.message')).not_to have_content not_admin.full_name
  end
end
