# frozen_string_literal: true

FactoryBot.define do
  factory :progress, class: 'Courses::Progress' do
    student
    lecture
    mentor
    homework_mark    { rand(-1..1) }
    lecture_presence { rand(-1..0) }
  end
end
