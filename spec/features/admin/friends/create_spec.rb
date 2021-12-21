# frozen_string_literal: true

RSpec.describe 'Friends CREATE' do
  let!(:group) { create(:group, resource: Friend) }

  before do
    assume_admin_logged_in
    visit '/admin/friends/new'
  end

  context 'when invalid input' do
    context 'when name is too short' do
      it 'validates errors' do
        fill_in 'Name', with: ''
        click_button 'Create Friend'

        expect_an_error friend_name: :blank
      end
    end
  end

  context 'when valid input' do
    it 'create new friend', :aggregate_failures do
      friend_attributes = build(:friend)
      name = 'Super New friend'
      description = friend_attributes.description
      link = friend_attributes.link

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Link', with: link
      attach_file('friend[logo]', Rails.root.join('spec/fixtures/images/pivorak.png'))
      select group.name, from: 'friend[group_id]'

      click_button 'Create Friend'

      friend = Friend.last

      expect(page).to have_current_path "/admin/friends/#{friend.id}/edit"
      expect(friend.name).to eq name
      expect(friend.description).to eq description
      expect(friend.link).to eq link
      expect(friend.group).to eq group
      expect(friend.logo).to be_present
    end
  end
end
