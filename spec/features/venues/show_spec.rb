# frozen_string_literal: true

RSpec.describe 'Venue SHOW' do
  let(:venue) { create(:venue) }

  before { visit "/venues/#{venue.slug}" }

  it 'displays venue info', :aggregate_failures do
    expect(page).to have_content(venue.name)
    expect(page).to have_content(venue.address)
  end
end
