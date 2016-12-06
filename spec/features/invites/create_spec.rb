RSpec.describe 'Invite features CREATE', vcr: { record: :new_episodes } do
  before do
    visit '/invites/new'
  end

  let(:email) { 'fake@mail.com' }

  context 'when valid input' do
    it 'sends invite' do
      fill_in 'email',  with: email
      click_button 'Get my Invite'

      expect(page).to have_content "Invite is sent to #{email}. Check your email."
    end
  end

  context 'when invalid input' do
    it 'shows error message' do
      fill_in 'email',  with: 'denys.medynskyi@gmail.com'
      click_button 'Get my Invite'

      expect(page).to have_content "Already in team"
    end
  end
end
