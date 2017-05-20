class Talk
  class Update < ApplicationService
    def initialize(talk, params)
      @talk   = talk
      @params = params
    end

    def call
      Talk::FetchExternalVideoData.call(talk)
      talk.update(params)
    end

    private

    attr_reader :talk, :params
  end
end
