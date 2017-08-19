module Bb
  class KnockController < BaseController
    before_action :execute_knock_policy

    private

    def execute_knock_policy
      return if access_policy.knock?

      redirect_to bb_root_path
    end
  end
end
