class User
  class Speakers < ApplicationFinder
    def call
      User.joins(:talks).having('count(talks.id) > 0').uniq
    end
  end
end
