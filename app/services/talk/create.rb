class Talk
  class Create < ApplicationService
    def initialize(talk)
      @talk = talk
    end

    def call
      return unless talk.valid?

      Talk::FetchExternalVideoData.call(talk)
      talk.save
    end

    private

    attr_reader :talk, :params
  end
end
