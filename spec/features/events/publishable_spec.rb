# frozen_string_literal: true

RSpec.describe 'Events publishable' do
  let!(:published_event)   { create :event, title: 'Published Event',   published: true }
  let!(:unpublished_event) { create :event, title: 'Unpublished Event', published: false }

  before { visit '/events' }

  it 'shows only published events', :aggregate_failures do
    expect(page).to     have_content 'Published Event'
    expect(page).not_to have_content 'Unpublished Event'
  end
end
