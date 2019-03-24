# frozen_string_literal: true

module MembersHelper
  GRAVATAR_URL = 'http://gravatar.com'

  def gravatar_website_link
    link_to t('members.change_gravatar'), GRAVATAR_URL, target: '_blank'
  end

  def gravatar_url(user)
    return "#{GRAVATAR_URL}/avatar/?d=mm" unless user&.email

    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "#{GRAVATAR_URL}/avatar/#{gravatar_id}.png"
  end

  def edit_profile_link
    link_to t('members.edit_profile'), edit_profile_path
  end

  def gravatar_image(user)
    image_tag gravatar_url(user)
  end
end
