#=== Users ====================================================================
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

#=== Groups ===================================================================
[:regular, :lighting, :workshop].each do |talk_type|
  Group.where(resource: Talk, name: talk_type).first_or_create!
end

[:sponsors, :meetups, :books, :resources].each do |friend_type|
  Group.where(resource: Friend, name: friend_type).first_or_create!
end

#=== Venues ===================================================================
Venue.where(name: 'iHUB', description: 'http://ihub.world/ua/lviv-ua/',
  address: 'Lviv, Zamknena Str 9',
  map_url: 'https://www.google.com/maps/place/%D0%B2%D1%83%D0%BB%D0%B8%D1%86%D1%8F+%D0%97%D0%B0%D0%BC%D0%BA%D0%BD%D0%B5%D0%BD%D0%B0,+9,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2%D1%81%D1%8C%D0%BA%D0%B0+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C,+%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D0%B0/@49.8404509,24.0134988,17z/data=!3m1!4b1!4m5!3m4!1s0x473add76e1c6ee3b:0xda08ff9150b3da68!8m2!3d49.8404475!4d24.0156875'
).first_or_create!

#=== Pages ====================================================================
Page.where(title: 'About Us', body: '...', url: 'about-us').first_or_create!
Page.where(title: 'Contacts', body: '...', url: 'contacts').first_or_create!

if Rails.env.development?
  #=== Venues ===================================================================
  100.times do
    Venue.create(name: Faker::StarWars.planet, description: Faker::StarWars.wookie_sentence,
      address: Faker::Address.street_address,
      map_url: 'https://www.google.com/maps/place/%D0%B2%D1%83%D0%BB%D0%B8%D1%86%D1%8F+%D0%97%D0%B0%D0%BC%D0%BA%D0%BD%D0%B5%D0%BD%D0%B0,+9,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2%D1%81%D1%8C%D0%BA%D0%B0+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C,+%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D0%B0/@49.8404509,24.0134988,17z/data=!3m1!4b1!4m5!3m4!1s0x473add76e1c6ee3b:0xda08ff9150b3da68!8m2!3d49.8404475!4d24.0156875'
    )
  end

  #=== Events ===================================================================
  100.times do
    Event.create(title: Faker::Lorem.word, agenda: Faker::Lorem.paragraph,
     status: Event::REGISTRATION, published: true,
     started_at: Time.now, finished_at: Time.now
    )
  end

  #=== Talks ====================================================================
  100.times do
    Talk.create(title: Faker::StarWars.planet, description: Faker::StarWars.quote)
  end

  #=== Goals ====================================================================
  100.times do
    Goal.create(title: Faker::StarWars.droid, amount: Faker::Commerce.price)
  end

  #=== Emails ===================================================================
  100.times do
    Email.create(subject: Faker::Hipster.sentence, body: Faker::Hipster.paragraph(10))
  end

  #=== Friends ==================================================================
  100.times do
    Friend.create(name: Faker::StarWars.character, description: Faker::Hipster.paragraph(10))
  end
end
