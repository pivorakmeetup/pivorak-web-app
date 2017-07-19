require 'rails_helper'

RSpec.describe Admin::Courses::Mentor::MentorPolicy do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { create(:user)}
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: 1) }
  let!(:user)           { create(:user, first_name: 'Another', last_name: 'User')}
  let!(:mentor) { ::Courses::Mentor.create(user_id: 2, season_id: 1) }


  context 'allow to destroy' do
    it 'allowed to destroy' do
      policy = Admin::Courses::Mentor::MentorPolicy.new(mentor, season)
      expect(policy.allowed_to_destroy?).to be_truthy
    end

    it 'not allowed to destroy' do
      policy = Admin::Courses::Mentor::MentorPolicy.new(season_creator, season)
      expect(policy.allowed_to_destroy?).to be_falsey
    end
  end
end