# frozen_string_literal: true

require 'rails_helper'

describe Courses::Homework::Create do
  let(:params) do
    { git_url: Faker::Internet.url, showcase_url: Faker::Internet.url,
                         description: Faker::Lorem.sentence, lecture_id: 1 }
  end
  let(:student_id) { 1 }

  describe '#call' do
    it 'creates homework' do
      homework = described_class.call(params, student_id)

      expect { homework.save }.to change { ::Courses::Homework.count }.by(1)
    end

    it 'creates homework with correct student_id' do
      homework = described_class.call(params, student_id)
      homework.save

      expect(homework.student_id).to eq(student_id)
    end
  end
end
