# frozen_string_literal: true

class Talk < ApplicationRecord
  class IncreasingPerMonth < ApplicationFinder
    include ::ChartsData

    def call
      hash_prefix_sum(talks)
    end

    private

    def talks
      @talks ||= Talk.group_by_month(:created_at).count
    end
  end
end
