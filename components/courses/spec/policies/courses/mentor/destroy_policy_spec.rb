# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Courses::Mentor::DestroyPolicy do
  let!(:season)         { create(:season, title: 'Test Season') }
  let!(:user)           { create(:user) }
  let!(:season_creator) { ::Courses::Mentor.create(user_id: 1, season_id: season.id) }
  let!(:user)           { create(:user, first_name: 'Another', last_name: 'User') }
  let!(:mentor)         { ::Courses::Mentor.create(user_id: 2, season_id: season.id) }

  context 'allow to destroy' do
    it 'allowed to destroy' do
      policy = Courses::Mentor::DestroyPolicy.new(mentor, season)

      expect(policy.allowed?).to be_truthy
    end

    it 'not allowed to destroy' do
      policy = Courses::Mentor::DestroyPolicy.new(season_creator, season)

      expect(policy.allowed?).to be_falsey
    end
  end
end
