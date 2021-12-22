# frozen_string_literal: true

RSpec.describe 'Talk publishable' do
  let(:event) { create :event }

  before do
    create :talk, title: 'Published Talk', event: event
    create :talk, title: 'Unpublished Talk', published: false, event: event
    create :talk, title: 'Without Event'

    visit '/talks'
  end

  it 'shows only published talks', :aggregate_failures do
    expect(page).to     have_content 'Published Talk'
    expect(page).not_to have_content 'Unpublished Talk'
    expect(page).not_to have_content 'Without Event'
  end
end
