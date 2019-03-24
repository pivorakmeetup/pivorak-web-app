# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::CancelAttendance do
  let(:student)    { create(:student, status: :test_task_done) }
  let(:season)     { create(:season, title: 'Test Season', status: :registation) }
  let(:user)       { User.create(email: 'test@test.com', first_name: 'Test', last_name: 'User') }

  describe '#call' do
    it 'creates cancel attendance' do
      ::Courses::Season::CancelAttendance.call(student)
      expect(student).to be_refused
    end
  end
end
