# frozen_string_literal: true

class User
  class VisitedEvents < ApplicationFinder
    def initialize(params = {})
      @user_id = params[:user_id]
    end

    def call
      Event.joins(:visit_requests).where(visit_requests: { visited: true, user_id: user_id })
    end

    private

    attr_reader :user_id
  end
end
