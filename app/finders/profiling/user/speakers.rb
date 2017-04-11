class Profiling::User
  class Speakers < ApplicationFinder
    def call
      Profiling::User.joins(:talks).having('count(talks.id) > 0').distinct
    end
  end
end
