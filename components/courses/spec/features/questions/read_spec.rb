require 'rails_helper'

RSpec.describe 'Questions READ' do
  context 'straight out of the box' do
    let!(:season)             { create(:season, title: 'Test Season') }
    let!(:user)               { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }
    let!(:season_creator)     { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
    let(:test_questions_path) { '/admin/courses/seasons/test-season/questions' }
    let!(:question_a)         { create(:question, body: 'Question A', season_id: season.id) }
    let!(:question_b)         { create(:question, body: 'Question B', season_id: season.id) }

    before { visit test_questions_path }

    it 'displays list of questions' do
      expect(page).to have_content 'Question A'
      expect(page).to have_content 'Question B'
    end
  end
end
