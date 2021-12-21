# frozen_string_literal: true

require 'rails_helper'

describe Courses::Student::Create do
  let(:params)  { attributes_for(:student) }
  let(:season)  { create(:season) }
  let(:user_id) { 3 }

  describe '#call' do
    it 'creates student' do
      student = described_class.call(params, season, user_id)

      expect { student.save }.to change { ::Courses::Student.count }.by(1)
    end

    it 'creates student with correct season' do
      student = described_class.call(params, season, user_id)
      student.save

      expect(student.season).to eq(season)
    end

    it 'creates student with correct user_id' do
      student = described_class.call(params, season, user_id)
      student.save

      expect(student.user_id).to eq(user_id)
    end

    describe 'open format season' do
      let(:season) { create(:season, open_format: true) }

      it 'creates attending student for open format season' do
        student = described_class.call(params, season, user_id)
        student.save

        expect(student).to be_attending
      end
    end
  end
end
