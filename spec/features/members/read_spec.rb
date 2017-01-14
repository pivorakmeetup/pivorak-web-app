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

  describe 'member talks' do
    context 'when user had talks' do
      it 'shows member talks' do
        user = create(:user)
        talk = create(:talk, speaker: user)

        visit "/members/#{user.id}"

        expect(page).to have_link(talk.title, "talks/#{talk.slug}")
      end
    end

    context 'when talk does not belong to user' do
      it 'shows member talks' do
        user = create(:user)
        talk = create(:talk)

        visit "/members/#{user.id}"

        expect(page).to_not have_link(talk.title, "talks/#{talk.slug}")
      end
    end
  end
end
