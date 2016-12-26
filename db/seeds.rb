#=== Users =====================================================================
User.where(email: 'pivorak.me@gmail.com').first_or_create!(
  first_name: 'Pivorak', last_name: 'Admin', password: 'password', admin: true
).confirm

User.where(email: 'user@mail.com').first_or_create!(
    first_name: 'User', last_name: 'Mail', password: '123456'
).confirm

