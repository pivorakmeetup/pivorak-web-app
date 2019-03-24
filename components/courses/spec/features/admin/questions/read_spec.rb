# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions READ' do
  context 'straight out of the box' do
    let!(:season)             { create(:season, title: 'Test Season', status: :planned) }
    let(:test_questions_path) { '/admin/courses/seasons/test-season/questions' }
    let!(:season_creator)     { ::Courses::Mentor.create(user_id: 1, season: season) }
    let!(:question_a)         { create(:question, body: 'Question A', season: season) }
    let!(:question_b)         { create(:question, body: 'Question B', season: season) }

    before { visit test_questions_path }

    it 'displays list of questions' do
      expect(page).to have_content 'Question A'
      expect(page).to have_content 'Question B'
    end
  end
end
