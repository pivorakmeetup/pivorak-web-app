# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test tasks LIST' do
  let!(:season) { create(:season, title: 'Test Season', status: :registration) }
  let!(:user_a) { User.create(email: 'test@test.com', first_name: 'A', last_name: 'User') }
  let!(:user_b) { User.create(email: 'user@test.com', first_name: 'B', last_name: 'User') }

  let!(:student_a) { create(:student, season: season, user: user_a) }
  let!(:student_b) { create(:student, season: season, user: user_b) }

  let!(:mentor_a) { ::Courses::Mentor.create(user: user_a, season: season) }
  let!(:mentor_b) { ::Courses::Mentor.create(user: user_b, season: season) }

  let!(:submited_test_task) { create(:test_task, student: student_a) }
  let!(:other_reviewing_test_task) { create(:test_task, student: student_b, mentor: mentor_b, status: :on_review) }

  before { visit '/admin/courses/seasons/test-season/test_task' }

  let(:submited_test_task_id) { "#test_task_#{submited_test_task.id}" }
  let(:other_reviewing_test_task_id) { "#test_task_#{other_reviewing_test_task.id}" }

  context 'shows test tasks with correct statuses and actions' do
    it 'allows take on review submited tasks' do
      within other_reviewing_test_task_id do
        expect(page).to have_content 'On Review'
        expect(page).to have_content "by #{mentor_b.full_name}"
      end

      within submited_test_task_id do
        expect(page).to have_content 'Submited'
        expect(page).to have_link 'Take on review'

        click_link 'Take on review'
      end

      within submited_test_task_id do
        expect(page).to have_content 'On Review'
        expect(page).to have_link 'Approve'
        expect(page).to have_link 'Take off review'

        click_link 'Take off review'
      end

      within submited_test_task_id do
        expect(page).to have_content 'Submited'
        expect(page).to have_link 'Take on review'

        click_link 'Take on review'
      end

      within submited_test_task_id do
        click_link 'Approve'
      end

      within submited_test_task_id do
        expect(page).to have_content 'Approved'
        expect(page).to have_content "by #{mentor_a.full_name}"
      end
    end
  end
end
