RSpec.describe 'Chat features CREATE INVITE', vcr: { record: :new_episodes } do
  before do
    visit '/chat'
  end

  let(:email) { 'fake@mail.com' }

  context 'when valid input' do
    it 'sends invite' do
      fill_in 'email',  with: email
      click_button 'Get My Invite'

      expect(page).to have_content "Invite is sent to #{email}. Check your email."
    end
  end

  context 'when invalid input' do
    it 'shows error message' do
      fill_in 'email',  with: ''
      click_button 'Get My Invite'

      expect(page).to have_content 'Email required'
    end
  end

  context 'when email already joined chat' do
    it 'shows error message' do
      fill_in 'email',  with: 'denys.medynskyi@gmail.com'
      click_button 'Get My Invite'

      expect(page).to have_content 'You are already in the team'
    end
  end
end
