#=== Users =====================================================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  first_name: 'Pivorak',
  last_name:  'Admin',
  password:   'password',
  admin:      true,
  verified:   true
).confirm

User.where(email: 'first@example.com').first_or_create!(
    first_name: 'First', last_name: 'User', password: 'password'
).confirm

User.where(email: 'second@example.com').first_or_create!(
    first_name: 'Second', last_name: 'User', password: 'password'
).confirm

#=== Groups ====================================================================
[:regular, :lighting, :workshop].each do |talk_type|
  Group.where(resource: Talk, name: talk_type).first_or_create!
end

[:sponsors, :meetups, :books, :resources].each do |friend_type|
  Group.where(resource: Friend, name: friend_type).first_or_create!
end
