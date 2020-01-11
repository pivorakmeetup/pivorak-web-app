# frozen_string_literal: true

RSpec.describe 'Events ASSIGN_TALK' do
  let!(:event) { create(:event, title: 'Test Event') }
  let(:test_edit_path) { '/admin/events/test-event/edit' }

  it 'only free talks can be assigned' do
    assigned = create(:talk, :assigned, title: 'talk-assigned')
    talk = create(:talk, title: 'talk')

    assume_admin_logged_in(supervisor: true)
    visit test_edit_path

    expect(page).to have_content(talk.title)
    expect(page).not_to have_content(assigned.title)
  end

  it 'assigned talks are checked as assigned' do
    talk = create(:talk, title: 'talk', event: event)

    assume_admin_logged_in(supervisor: true)
    visit test_edit_path

    expect(page).to have_checked_field(talk.title)
  end

  it 'assigns talk to event' do
    talk = create(:talk, title: 'talk')

    assume_admin_logged_in(supervisor: true)
    visit test_edit_path

    page.check talk.title
    click_button 'Update Event'

    expect(event.talks).to include talk
  end
end
