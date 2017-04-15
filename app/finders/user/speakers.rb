class User
  class Speakers < ApplicationFinder
    def call
      User.joins(:talks).having('count(talks.id) > 0').group('users.id')
    end
  end
end
