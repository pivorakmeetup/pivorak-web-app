# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lectures LIST' do
  let(:season)          { create(:season, title: 'Test Season', status: :live) }
  let(:user)            { create(:user) }
  let(:venue)           { create(:venue) }
  let(:season_creator)  { create(:mentor, user: user, season: season) }
  let!(:lecture)         { create(:lecture, mentor: season_creator, venue: venue, season: season) }
  let!(:another_lecture) { create(:lecture, mentor: season_creator, venue: venue, season: season) }

  context 'when open existing page' do
    before { visit '/admin/courses/seasons/test-season/lectures/' }

    it { expect(page).to have_content(lecture.title) }
    it { expect(page).to have_content(another_lecture.title) }
  end
end
