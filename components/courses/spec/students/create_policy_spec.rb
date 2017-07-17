require 'spec_helper'
require './app/policies/courses/student/create_policy.rb'

describe Courses::Student::CreatePolicy do
  let(:user_id) { 1 }
  let(:season)  { create(:season, title: 'Test Season') }

  describe '#allowed?' do
    context 'user has no applications' do
      it 'allows to pass policy' do
        policy = Courses::Student::CreatePolicy.new(user_id, season)
        expect(policy.allowed?).to be(true)
      end
    end

    context 'user has application' do
      it 'forbids to pass policy' do
        allow(season).to receive_message_chain(:students, :exists?).and_return(true)
        policy = Courses::Student::CreatePolicy.new(user_id, season)
        expect(policy.allowed?).to be(false)
      end
    end
  end
end
