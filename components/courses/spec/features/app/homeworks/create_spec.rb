# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homework CREATE' do
  let(:season)          { create(:season, title: 'Test Season', status: :live) }
  let(:user)            { create(:user, email: 'test@test.com', first_name: 'Test', last_name: 'User') }
  let!(:lecture) { create(:lecture, season: season) }

  before do
    create(:student, season: season, user: user)
    create(:mentor, user: user, season: season)

    visit '/courses/seasons/test-season/homeworks/new'
  end

  describe 'invalid input' do
    context 'with blank git_url' do
      it 'validates errors' do
        fill_in 'Git url', with: ''
        click_button 'Submit'

        expect_an_error homework_git_url: :blank
      end
    end
  end

  describe 'valid input' do
    it 'creates new homework' do
      fill_in 'Git url', with: 'https://github.com/test_student/homework_test'
      select lecture.title, from: 'homework[lecture_id]'

      expect { click_button 'Submit' }.to change { ::Courses::Homework.count }.by(1)
    end
  end
end
