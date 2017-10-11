module Bb
  module BbHelper
    def knock_knock_section
      return unless access_policy.can_knock? && !access_policy.reviewing?

      render 'bb/home/knock_knock'
    end

    def knock_review_section
      return unless access_policy.reviewing?

      render 'bb/home/knock_reviewing'
    end

    def knock_knock_link
      link_to t('bb.home.knock_knock'), new_bb_knock_path
    end
  end
end
