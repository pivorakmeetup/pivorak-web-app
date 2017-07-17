require 'spec_helper'
require './app/services/courses/student/create.rb'

describe Courses::Student::Create do
  let(:params)    { {status: 0, personal_info: "Skills", motivation_info: "Reasons"} }
  let(:season_id) {2}
  let(:user_id)   {3}

  describe '#call' do
    it 'creates student' do
      student = Courses::Student::Create.call(params, season_id, user_id)
      expect { student.save }.to change { ::Courses::Student.count }.by(1)
    end

    it 'creates student with correct season_id' do
      student = Courses::Student::Create.call(params, season_id, user_id)
      student.save
      expect(student.season_id).to eq(season_id)
    end

    it 'creates student with correct user_id' do
      student = Courses::Student::Create.call(params, season_id, user_id)
      student.save
      expect(student.user_id).to eq(user_id)
    end
  end
end
