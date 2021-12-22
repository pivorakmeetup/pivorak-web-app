# frozen_string_literal: true

RSpec.describe 'Events publishable' do
  before do
    create :event, title: 'Published Event',   published: true
    create :event, title: 'Unpublished Event', published: false

    visit '/events'
  end

  it 'shows only published events', :aggregate_failures do
    expect(page).to     have_content 'Published Event'
    expect(page).not_to have_content 'Unpublished Event'
  end
end
