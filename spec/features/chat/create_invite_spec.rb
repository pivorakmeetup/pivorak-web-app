RSpec.describe 'Chat features CREATE INVITE' do
  before do
    visit '/chat'
  end

  let(:email) { 'fake@mail.com' }

  context 'when valid input' do
    before do
      expect(Chat::Invite).to receive(:call).with(email) { true }
    end

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
    before do
      allow(Chat::Invite).to receive(:call).and_raise(Chat::Client::ChatError.new(I18n.t('chat.errors.already_in_team')))
    end

    it 'shows error message' do
      fill_in 'email',  with: 'denys.medynskyi@gmail.com'
      click_button 'Get My Invite'

      expect(page).to have_content 'You are already in the team'
    end
  end
end
