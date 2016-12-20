#=== Users =====================================================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  first_name: 'Pivorak',
  last_name:  'Admin',
  password:   'password',
  admin:      true
).confirm
