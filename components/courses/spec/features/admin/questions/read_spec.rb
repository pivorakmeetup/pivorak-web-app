# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions READ' do
  describe 'straight out of the box' do
    let(:season) { create(:season, title: 'Test Season', status: :planned) }
    let(:test_questions_path) { '/admin/courses/seasons/test-season/questions' }

    before do
      create(:mentor, season: season)
      create(:question, body: 'Question A', season: season)
      create(:question, body: 'Question B', season: season)
      visit test_questions_path
    end

    it 'displays list of questions', :aggregate_failures do
      expect(page).to have_content 'Question A'
      expect(page).to have_content 'Question B'
    end
  end
end
