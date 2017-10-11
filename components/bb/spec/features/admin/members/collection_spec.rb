require 'rails_helper'

RSpec.describe 'Members collection' do
  let(:user)    { create(:user, first_name: 'First', last_name: 'Member') }
  let!(:member) { create :member, user: user }

  it 'list all members' do
    visit '/admin/bb/members'

    expect(page).to have_content 'First Member'
  end
end
