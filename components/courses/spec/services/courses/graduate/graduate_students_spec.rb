# frozen_string_literal: true

require 'rails_helper'

describe Courses::Graduate::GraduateStudents do
  let(:season) { create(:season,  title: 'Test Season', status: :passed) }
  let!(:attending_student) { create(:student, status: :attending, season: season) }
  let!(:dropped_student)   { create(:student, status: :dropped, season: season) }

  describe '#call' do
    it 'graduates attending students', :aggregate_failures do
      described_class.call(season)

      attending_student.reload
      dropped_student.reload

      expect(attending_student.status).to eq('graduated')
      expect(dropped_student.status).to eq('dropped')
    end
  end
end
