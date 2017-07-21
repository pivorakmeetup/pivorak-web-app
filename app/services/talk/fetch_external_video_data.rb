class Talk
  class FetchExternalVideoData < ApplicationService
    VIDEO_ID_REGEX = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/.freeze

    def self.fetch_all!
      logger = Logger.new(Rails.root.join('log', 'fetch_external_video_data.log'))

      logger.info "==================== #{Time.now} ===================="
      Talk.find_each do |talk|
        begin
          new(talk).call
          logger.info "Talk #{talk.id} was successfully fetched! #{talk.extra_video_data}"
        rescue => ex
          logger.error "Cannot fetch talk #{talk.id} data: #{ex.class}: #{ex.message}"
        end
      end
    end

    def initialize(talk)
      @talk = talk
    end

    def call
      return unless talk.video_url && video_id

      talk.extra['video_duration']    = video.duration
      talk.extra['video_likes_count'] = video.like_count
      talk.extra['video_views_count'] = video.view_count

      talk.save
    end

    private

    attr_reader :talk

    def video
      @video ||= Yt::Video.new(id: video_id)
    end

    def video_id
      @video_id ||= talk.video_url.match(VIDEO_ID_REGEX)[1] rescue nil
    end
  end
end
