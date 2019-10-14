# frozen_string_literal: true

require 'rails_helper'

describe Courses::Student::Drop do
  let!(:student) { create(:student, status: :attending) }

  describe '#call' do
    it 'drops student' do
      described_class.call(student)

      expect(student.status).to eq('dropped')
    end
  end
end
