require 'rails_helper'

RSpec.describe 'Seasons SHOW' do
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }

  context 'season is passed' do
    let!(:season)            { create(:season, title: 'Test Season', status: :passed) }
    let!(:attending_student) { create(:student, status: :attending, season: season) }
    let!(:dropped_student)   { create(:student, status: :dropped, season: season) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'graduates attending students' do
      click_link 'Graduate students!'

      attending_student.reload
      dropped_student.reload

      expect(attending_student.status).to eq('graduated')
      expect(dropped_student.status).to eq(dropped_student.status)
    end
  end

  context 'season is not passed' do
    let!(:season)    { create(:season, title: 'Test Season', status: :live) }

    before { visit '/admin/courses/seasons/test-season' }

    it 'can not graduate students' do
      expect(page).not_to have_content 'Graduate students!'
    end
  end
end
