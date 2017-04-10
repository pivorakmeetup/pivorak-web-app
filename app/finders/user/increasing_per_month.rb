class Authentication::User
  class IncreasingPerMonth < ApplicationFinder
    include ::ChartsData

    def call
      hash_prefix_sum(users)
    end

    private

    attr_reader :users

    def users
      @users ||= User.group_by_month(:created_at).count
    end
  end
end
