#=== Users =====================================================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  first_name: 'Pivorak', last_name: 'Admin', password: 'password', admin: true
).confirm

User.where(email: 'user@mail.com').first_or_create!(
    first_name: 'User', last_name: 'Mail', password: '123456'
).confirm

#=== Groups ====================================================================
[:regular, :lighting, :workshop].each do |talk_type|
  Group.where(resource: Talk, name: talk_type).first_or_create!
end
