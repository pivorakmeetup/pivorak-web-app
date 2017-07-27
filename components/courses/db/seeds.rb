#=== Seasons ============================================================================

puts ::Courses::Season.where(title: 'Sample season').first_or_create!(
    start_at: Time.now, finish_at: Time.now + 100.days, status: :live
)

puts ::Courses::Season.where(title: 'Planned season').first_or_create!(
    start_at: Time.now, finish_at: Time.now + 100.days, status: :planned
)

#=== Questions ==========================================================================

5.times { puts ::Courses::Question.where(season_id: 1, body: Faker::ChuckNorris.fact).first_or_create! }

#=== Mentors ============================================================================

puts ::Courses::Mentor.where(user_id: 1, season_id: 1).first_or_create!

puts ::Courses::Mentor.where(user_id: 1, season_id: 2).first_or_create!

#=== Students ===========================================================================

puts ::Courses::Student.where(user_id: 1, season_id: 1).first_or_create!(
    personal_info: 'Lorem', motivation_info: 'Ipsum', status: :test_task_done
)

puts ::Courses::Student.where(user_id: 2, season_id: 1).first_or_create!(
    personal_info: 'Lorem', motivation_info: 'Ipsum', status: :interviewing
)

puts ::Courses::Student.where(user_id: 3, season_id: 1).first_or_create!(
    personal_info: 'Lorem', motivation_info: 'Ipsum', status: :attending
)

puts ::Courses::Student.where(user_id: 4, season_id: 1).first_or_create!(
    personal_info: 'Lorem', motivation_info: 'Ipsum', status: :attending
)

#=== Test tasks =========================================================================

puts ::Courses::TestTask.where(student_id: 2).first_or_create!(
    git_url: 'Lorem', showcase_url: 'Ipsum', comment: 'Dolor'
)

puts ::Courses::TestTask.where(student_id: 3).first_or_create!(
    git_url: 'Lorem', showcase_url: 'Ipsum', comment: 'Dolor', mentor_id: 1
)

puts ::Courses::TestTask.where(student_id: 4).first_or_create!(
    git_url: 'Lorem', showcase_url: 'Ipsum', comment: 'Dolor', mentor_id: 1
)

#=== Interviews =========================================================================

puts ::Courses::Interview.where(mentor_id: 1, student_id: nil).first_or_create!(
    start_at: Time.now
)

puts ::Courses::Interview.where(mentor_id: 1, student_id: 3).first_or_create!(
    start_at: Time.now, status: :completed
)

puts ::Courses::Interview.where(mentor_id: 1, student_id: 4).first_or_create!(
    start_at: Time.now, status: :completed
)

#=== Interview Assessments ==============================================================

5.times do |n|
  puts ::Courses::InterviewAssessment.where(interview_id: 2, question_id: n + 1).first_or_create!(
      mentor_id: 1, mark: rand(1..5)
  )

  puts ::Courses::InterviewAssessment.where(interview_id: 3, question_id: n + 1).first_or_create!(
      mentor_id: 1, mark: rand(1..5)
  )
end

#=== Lectures ===========================================================================

puts ::Courses::Lecture.where(title: 'First lecture').first_or_create!(
    season_id: 1, mentor_id: 1, started_at: Time.now, finished_at: Time.now + 2.hours, venue_id: 1,
    status: :passed
)

puts ::Courses::Lecture.where(title: 'Second lecture').first_or_create!(
    season_id: 1, mentor_id: 1, started_at: Time.now + 1.day, finished_at: Time.now + 26.hours, venue_id: 1,
    status: :upcoming
)

#=== Homeworks ==========================================================================

puts ::Courses::Homework.where(lecture_id: 1, student_id: 3).first_or_create!(
    git_url: 'Lorem', showcase_url: 'Ipsum', description: 'Dolor'
)

puts ::Courses::Homework.where(lecture_id: 1, student_id: 4).first_or_create!(
    git_url: 'Lorem', description: 'Dolor'
)

#=== Progresses =========================================================================

puts ::Courses::Progress.where(lecture_id: 1, student_id: 3).first_or_create!(
    mentor_id: 1, lecture_presence: -1, homework_mark: 1
)

puts ::Courses::Progress.where(lecture_id: 1, student_id: 4).first_or_create!(
    mentor_id: 1, homework_mark: 0
)

puts ::Courses::Progress.where(lecture_id: 2, student_id: 3).first_or_create!(
    mentor_id: 1
)

puts ::Courses::Progress.where(lecture_id: 2, student_id: 4).first_or_create!(
    mentor_id: 1
)
