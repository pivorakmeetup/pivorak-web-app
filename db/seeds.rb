#=== Users ======================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  first_name: 'Pivorak', last_name: 'Me', password: 'password', admin: true
)

User.where(email: 'user@mail.com').first_or_create!(
    first_name: 'User', last_name: 'Mail', password: '123456'
)
