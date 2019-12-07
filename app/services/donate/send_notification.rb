module Donate
  class SendNotification < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      
    end
  end
end
