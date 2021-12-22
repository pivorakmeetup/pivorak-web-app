# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons SHOW' do
  let(:season) { create(:season, title: 'Test Season', status: :passed) }

  before do
    create(:mentor, season: season)
  end

  context 'when season is passed' do
    let!(:attending_student) { create(:student, status: :attending, season: season) }
    let!(:dropped_student) { create(:student, status: :dropped, season: season) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'graduates attending students', :aggregate_failures do
      click_link 'Graduate students!'

      attending_student.reload
      dropped_student.reload

      expect(attending_student.status).to eq('graduated')
      expect(dropped_student.status).to eq('dropped')
    end

    it 'shows right tabs', :aggregate_failures do
      expect(page).to have_link('/admin/courses/seasons/test-season')
      expect(page).to have_link('/admin/courses/seasons/test-season/mentors')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/questions')
      expect(page).to have_link('/admin/courses/seasons/test-season/students')
      expect(page).to have_link('/admin/courses/seasons/test-season/test_task')
      expect(page).to have_link('/admin/courses/seasons/test-season/interviews')
      expect(page).to have_link('/admin/courses/seasons/test-season/lectures')
      expect(page).to have_link('/admin/courses/seasons/test-season/journal')
    end
  end

  context 'when season is live' do
    let(:season) { create(:season, title: 'Test Season', status: :live) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'can not graduate students' do
      expect(page).not_to have_content 'Graduate students!'
    end

    it 'shows right tabs', :aggregate_failures do
      expect(page).to have_link('/admin/courses/seasons/test-season')
      expect(page).to have_link('/admin/courses/seasons/test-season/mentors')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/questions')
      expect(page).to have_link('/admin/courses/seasons/test-season/students')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/test_task')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/interviews')
      expect(page).to have_link('/admin/courses/seasons/test-season/lectures')
      expect(page).to have_link('/admin/courses/seasons/test-season/journal')
    end
  end

  context 'when season is in selection phase' do
    let(:season) { create(:season, title: 'Test Season', status: :selection) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'shows right tabs', :aggregate_failures do
      expect(page).to     have_link('/admin/courses/seasons/test-season')
      expect(page).to     have_link('/admin/courses/seasons/test-season/mentors')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/questions')
      expect(page).to     have_link('/admin/courses/seasons/test-season/students')
      expect(page).to     have_link('/admin/courses/seasons/test-season/test_task')
      expect(page).to     have_link('/admin/courses/seasons/test-season/interviews')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/lectures')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/journal')
    end
  end

  context 'when season is in registration phase' do
    let(:season) { create(:season, title: 'Test Season', status: :registration) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'shows right tabs', :aggregate_failures do
      expect(page).to     have_link('/admin/courses/seasons/test-season')
      expect(page).to     have_link('/admin/courses/seasons/test-season/mentors')
      expect(page).to     have_link('/admin/courses/seasons/test-season/questions')
      expect(page).to     have_link('/admin/courses/seasons/test-season/students')
      expect(page).to     have_link('/admin/courses/seasons/test-season/test_task')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/interviews')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/lectures')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/journal')
    end
  end

  context 'when season is planned' do
    let(:season) { create(:season, title: 'Test Season', status: :planned) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'shows right tabs', :aggregate_failures do
      expect(page).to     have_link('/admin/courses/seasons/test-season')
      expect(page).to     have_link('/admin/courses/seasons/test-season/mentors')
      expect(page).to     have_link('/admin/courses/seasons/test-season/questions')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/students')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/test_task')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/interviews')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/lectures')
      expect(page).not_to have_link('/admin/courses/seasons/test-season/journal')
    end
  end
end
