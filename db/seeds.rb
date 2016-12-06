#=== Users ======================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  name: 'Pivorak', password: 'password', admin: true
)

User.where(email: 'user@mail.com').first_or_create!(
    name: 'Simple Man', password: '123456'
)
