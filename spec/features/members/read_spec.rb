RSpec.describe 'Member READ' do
  let (:member) { create(:user, :tester) }

  describe 'single' do
    context 'any visitor'
      before { visit "/members/#{member.id}" }

      it { expect(page).to have_content('Tester User') }
  end
end
