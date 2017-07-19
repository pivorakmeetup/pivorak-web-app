require 'rails_helper'

RSpec.describe Courses::Interview::IntervalPolicy do
  let!(:season)          { create(:season) }
  let!(:user)            { create(:user) }
  let!(:mentor)          { ::Courses::Mentor.create(user_id: user.id, season_id: season.id) }
  let!(:first_student)   { create(:student) }
  let!(:second_student)  { create(:student) }
  let!(:third_student)   { create(:student) }
  let!(:interval)        { 30 }
  let!(:first_interview) { create(:interview,  mentor_id:  mentor.id,
                                               student_id: first_student.id,
                                               season_id:  season.id,
                                               start_at:   Time.now - 20.minutes)}
  let!(:second_interview) { create(:interview, mentor_id:  mentor.id,
                                               student_id: second_student.id,
                                               season_id:  season.id,
                                               start_at:   Time.now + 20.minutes)}
  

  context 'allow to create interview' do
    it 'allowed to create' do
      new_interview = ::Courses::Interview.new(mentor_id:  mentor.id,
                                           student_id: third_student.id,
                                           season_id:  season.id,
                                           start_at:   Time.now + 80.minutes)

      policy = Courses::Interview::IntervalPolicy.new(mentor, new_interview, interval)

      expect(policy.allowed?).to be_truthy
    end

    it 'not allowed to destroy' do
      new_interview = ::Courses::Interview.new(mentor_id:  mentor.id,
                                           student_id: third_student.id,
                                           season_id:  season.id,
                                           start_at:   Time.now)

      policy = Courses::Interview::IntervalPolicy.new(mentor, new_interview, interval)

      expect(policy.allowed?).to be_falsey
    end
  end
end
