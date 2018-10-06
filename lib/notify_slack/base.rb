module NotifySlack
  class Base
    def initialize(student_id)
      @notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'],
                                      channel: ENV['SLACK_CHANNEL'],
                                      username: ENV['SLAsCK_USERNAME'])
      @student_id = student_id
    end

    attr_accessor :notifier, :student_id

    def call
      student = Courses::Student.find(student_id)
      season = student.season
      notifier.ping("Student #{student.user.email} enrolled to course #{season.title}")
    end
  end
end
