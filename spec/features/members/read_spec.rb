# frozen_string_literal: true

RSpec.describe 'Member READ' do
  let(:member) { create(:user, :tester) }

  describe 'single' do
    context 'any visitor'
    before { visit "/members/#{member.id}" }

    it { expect(page).to have_content('Tester User') }
  end

  describe 'plural' do
    context 'any visitor'
    before do
      member
      visit '/members'
    end

    it { expect(page).to have_content('Tester User') }

    it { expect(find(:xpath, "//a[@href='/members/#{member.slug}']").text).to eq 'Tester User' }

    it { click_link('Tester User') }
  end

  describe 'member talks' do
    context 'when user had talks' do
      it 'shows member talks' do
        user = create(:user)
        talk = create(:talk, speaker: user)

        visit "/members/#{user.id}"

        expect(find(:xpath, "//a[@href='/talks/#{talk.slug}']").text).to eq talk.title
      end
    end

    context 'when talk does not belong to user' do
      it 'shows member talks' do
        user = create(:user)
        talk = create(:talk)

        visit "/members/#{user.id}"

        expect(page).not_to have_link(talk.title, href: "talks/#{talk.slug}")
      end
    end
  end

  describe 'member events' do
    it 'shows member visited events', :aggregate_failures do
      user = create(:user)
      visited_event = create(:event)
      not_visited_event = create(:event, title: 'not visited')
      other_not_visited_event = create(:event, title: 'not visited-2')
      create(:visit_request, event: not_visited_event, user: user)
      create(:visit_request, :visited, event: visited_event, user: user)
      create(:visit_request, :visited, event: other_not_visited_event)

      visit "/members/#{user.id}"

      expect(find(:xpath, "//a[@href='/events/#{visited_event.slug}']").text).to eq visited_event.title
      expect(page).not_to have_link(not_visited_event.title, href: "events/#{not_visited_event.slug}")
    end
  end
end
