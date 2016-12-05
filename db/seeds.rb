#=== Users ======================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  name: 'Pivorak', password: 'password', admin: true
)
