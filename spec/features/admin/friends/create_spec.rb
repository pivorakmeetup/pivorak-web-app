RSpec.describe 'Friends CREATE' do
  let!(:group) { create(:group, resource: Friend) }

  before do
    assume_admin_logged_in
    visit '/admin/friends/new'
  end

  context 'invalid input' do
    context 'when name is too short' do
      it 'validates errors' do
        fill_in 'Name',  with: ''
        click_button 'Create Friend'

        expect_an_error friend_name:  :blank
      end
    end
  end

  context 'valid input' do
    it 'create new friend' do
      friend_attributes = build(:friend)
      name = 'Super New friend'
      description = friend_attributes.description
      link = friend_attributes.link

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Link', with: link
      click_button 'Create Friend'

      friend = Friend.last

      expect(page).to have_current_path "/admin/friends/#{friend.id}/edit"
      expect(friend.name).to eq name
      expect(friend.description).to eq description
      expect(friend.link).to eq link
    end

    it 'create friend in group' do
      fill_in 'Name',  with: 'Super New friend'

      select group.name, :from => 'friend[group_id]'

      click_button 'Create Friend'

      expect(Friend.last.group_id).to eq group.id
    end

    it 'creates friend with image' do
      fill_in 'Name',  with: 'Super New friend'
      attach_file('friend[logo]', Rails.root + 'spec/fixtures/images/pivorak.png')

      click_button 'Create Friend'

      expect(Friend.last.logo).to be_present
    end
  end
end
