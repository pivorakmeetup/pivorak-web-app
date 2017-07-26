FactoryGirl.define do
  factory :progress, class: Courses::Progress do
    student_id       { rand(1..100) }
    lecture_id       { rand(1..100) }
    mentor_id        { rand(1..100) }
    homework_mark    { rand(-1..1) }
    lecture_presence { rand(-1..0) }
  end
end
