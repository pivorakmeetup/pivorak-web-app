# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Interviews LIST' do
  let(:season)    { create(:season, title: 'Test Season', status: :selection) }
  let(:user)      { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let(:student)   { create(:student, user: user, season: season, status: :interviewing) }
  let(:mentor)    { create(:mentor, user: user, season: season) }

  before do
    create :interview, mentor: mentor, student: student, status: :completed

    visit '/admin/courses/seasons/test-season/interviews/'
  end

  context 'when open existing page' do
    it { expect(page).to have_content(mentor.full_name) }
  end

  context 'when interview approve' do
    it 'approves student' do
      click_link 'Approve'

      expect(::Courses::Student.last.status).to eq('attending')
    end
  end
end
