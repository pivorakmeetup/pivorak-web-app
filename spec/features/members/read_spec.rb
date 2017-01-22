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

  describe 'member events' do
    it 'shows member visited events' do
      user = create(:user)
      visited_event = create(:event)
      not_visited_event = create(:event, title: 'not visited')
      not_visited_event_2 = create(:event, title: 'not visited-2')
      create(:visit_request, event: not_visited_event, user: user)
      create(:visit_request, :visited, event: visited_event, user: user)
      create(:visit_request, :visited, event: not_visited_event_2)

      visit "/members/#{user.id}"

      expect(page).to have_link(visited_event.title, "events/#{visited_event.slug}")
      expect(page).to_not have_link(not_visited_event.title, "events/#{not_visited_event.slug}")
    end
  end
end
