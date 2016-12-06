module GravatarHelper
  def gravatar_url(user)
    return 'http://www.gravatar.com/avatar/?d=mm' unless user&.email

    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
