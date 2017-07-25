require 'rails_helper'

describe Courses::Interview::ApprovePolicy do
  let!(:season)    { create(:season, title: 'Test Season', status: :selection) }
  let!(:user)      { create(:user) }
  let!(:mentor)    { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:student)   { create(:student, season_id: season.id, user_id: user.id, status: :interviewing) }
  let!(:interview) { create(:interview, mentor_id: mentor.id, student_id: student.id, status: :completed) }

  describe '#allowed?' do
    context 'mentor allowed to approve student after interview' do
      it 'allows to pass policy' do
        policy = Courses::Interview::ApprovePolicy.new(user, season, interview)
        expect(policy).to be_allowed
      end
    end
  end
end
