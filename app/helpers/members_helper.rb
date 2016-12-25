module MembersHelper
  GRAVATAR_URL = 'http://gravatar.com'.freeze

  def gravatar_website_link
    link_to t('members.change_gravatar'), GRAVATAR_URL, target: '_blank'
  end

  def gravatar_url(user)
    return "#{GRAVATAR_URL}/avatar/?d=mm" unless user&.email

    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "#{GRAVATAR_URL}/avatar/#{gravatar_id}.png"
  end

  def edit_profile_link
    link_to t('members.edit_profile'), edit_profile_path
  end

  def gravatar_image(user)
    image_tag gravatar_url(user)
  end

  def synthetic_user?
    params[:synthetic].present? && synthetic_user
  end

  def synthetic_user
    @synthetic_user ||= User::CheckSynthetic.call(params[:synthetic])
  end

  def get_account_control_link
    link_to t('members.synthetic.get_account'),
      password_path(resource_name, user: { email: synthetic_user.email }),
      method: :post
    end
end
