# frozen_string_literal: true

RSpec.describe 'Talks READ' do
  context 'without any assignes' do
    let!(:talk_a)    { create(:talk, title: 'Test Talk A') }
    let!(:talk_b)    { create(:talk, title: 'Test Talk B') }

    before do
      assume_admin_logged_in
      visit '/admin/talks'
    end

    it { expect(page).to have_link 'Test Talk A' }
    it { expect(page).to have_link 'Test Talk B' }
    it { expect(page).to have_link 'New Talk' }
    it { expect(page).to have_link('Edit', count: 2) }
    it 'New Talk click redirect to #new' do
      click_link 'New Talk'
      expect(page).to have_current_path('/admin/talks/new')
    end
  end

  context 'with event assign' do
    let(:event) { create(:event) }
    let!(:talk_with_event) { create(:talk, title: 'Test Talk with Event', event_id: event.id) }

    before do
      assume_admin_logged_in
      visit '/admin/talks'
    end

    it { expect(page).to have_link talk_with_event.title }
    it { expect(page).to have_link event.title }
    it 'Event click redirect to event#show' do
      click_link event.title
      expect(page).to have_current_path("/events/#{event.slug}")
    end
  end

  context 'with user assign' do
    let(:user)       { create(:user, first_name: 'Super', last_name: 'User') }
    let!(:talk_with_user) { create(:talk, title: 'Test Talk with User', speaker_id: user.id) }

    before do
      assume_admin_logged_in
      visit '/admin/talks'
    end

    it { expect(page).to have_link 'Test Talk with User' }
    it { expect(page).to have_content 'Super User' }
  end

  context 'when talks list should be ordered by creation_date desc' do
    let!(:talk_firstly_created)    { create(:talk, title: 'Test Talk A') }
    let!(:talk_secondly_created)   { create(:talk, title: 'Test Talk B') }
    let!(:talk_lastly_created)     { create(:talk, title: 'Test Talk C') }

    before do
      Capybara.ignore_hidden_elements = false
      assume_admin_logged_in
      visit '/admin/talks'
    end

    after { Capybara.ignore_hidden_elements = true }

    it { expect(page).to have_text(/(Test Talk C).+(Test Talk B).+(Test Talk A)/) }
  end
end
