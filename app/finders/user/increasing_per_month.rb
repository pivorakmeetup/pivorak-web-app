# frozen_string_literal: true

class User < ApplicationRecord
  class IncreasingPerMonth < ApplicationFinder
    include ::ChartsData

    def call
      hash_prefix_sum(users)
    end

    private

    def users
      @users ||= User.group_by_month(:created_at).count
    end
  end
end
