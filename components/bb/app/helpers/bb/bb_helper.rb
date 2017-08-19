module Bb
  module BbHelper
    def knock_knock_section
      return unless access_policy.knock?

      render 'bb/home/knock_knock'
    end

    def knock_knock_link
      link_to t('bb.home.knock_knock'), new_bb_knock_path
    end
  end
end
