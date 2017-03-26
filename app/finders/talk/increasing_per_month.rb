class Talk < ApplicationRecord
  class IncreasingPerMonth < ApplicationFinder
    include ::ChartsData

    def call
      hash_prefix_sum(talks)
    end

    private

    attr_reader :talks

    def talks
      @talks ||= Talk.group_by_month(:created_at).count
    end
  end
end
