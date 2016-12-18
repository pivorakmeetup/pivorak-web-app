RSpec.describe 'Member READ' do
  let (:member) { create(:user, :tester) }

  describe 'single' do
    context 'any visitor'
      before { visit "/members/#{member.id}" }

      it { expect(page).to have_content('Tester User') }
  end

  describe 'plural' do
    context 'any visitor'
    before do
      member
      visit "/members"
    end

    it { expect(page).to have_content('Tester User') }

    it { expect(page).to have_link(nil, "members/#{member.slug}") }

    it { click_link('Tester User') }
  end
end
