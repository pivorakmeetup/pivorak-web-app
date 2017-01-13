RSpec.describe 'Friends CREATE' do
  let!(:friend) { create(:friend, group: group) }
  let!(:group) { create(:group, resource: Friend) }

  before do
    assume_admin_logged_in
    visit "/admin/friends/#{friend.id}/edit"
  end

  context 'invalid input' do
    context 'when name is too short' do
      it 'validates errors' do
        fill_in 'Name',  with: ''
        click_button 'Update Friend'

        expect_an_error friend_name:  :blank
      end
    end
  end

  context 'valid input' do
    it 'updates friend' do
      friend_attributes = build(:friend)
      name = 'Super New friend'
      description = friend_attributes.description
      link = friend_attributes.link

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Link', with: link
      click_button 'Update Friend'

      expect(page).to have_current_path "/admin/friends/#{friend.id}/edit"
      
      expect(friend.reload.name).to eq name
      expect(friend.reload.description).to eq description
      expect(friend.reload.link).to eq link
    end
  end
end
