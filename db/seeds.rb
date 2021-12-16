# frozen_string_literal: true

require 'factory_bot_rails'

#=== Users ====================================================================
puts User.where(email: 'admin@pivorak.com').first_or_create!(
  first_name: 'Pivorak',
  last_name:  'Admin',
  password:   'password',
  admin:      true,
  verified:   true
).confirm

cover = File.open(Rails.root.join('db', 'pivorak_speaker.png'))

puts User.where(email: 'first@example.com').first_or_create!(
  first_name: 'First', last_name: 'User', password: 'password', cover: cover
).confirm

puts User.where(email: 'second@example.com').first_or_create!(
  first_name: 'Second', last_name: 'User', password: 'password', cover: cover
).confirm

puts User.where(email: 'third@example.com').first_or_create!(
  first_name: 'Third', last_name: 'User', password: 'password', cover: cover
).confirm

#=== Groups ===================================================================
%i[regular lighting workshop].each do |talk_type|
  puts Group.where(resource: 'Talk', name: talk_type).first_or_create!
end

%i[sponsors meetups books resources].each do |friend_type|
  puts Group.where(resource: 'Friend', name: friend_type).first_or_create!
end

#=== Venues ===================================================================
puts Venue.where(name: 'iHUB', description: 'http://ihub.world/ua/lviv-ua/',
                 address: 'Lviv, Zamknena Str 9',
                 map_url: 'https://www.google.com/maps/place/%D0%B2%D1%83%D0%BB%D0%B8%D1%86%D1%8F+%D0%97%D0%B0%D0%BC%D0%BA%D0%BD%D0%B5%D0%BD%D0%B0,+9,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2,+%D0%9B%D1%8C%D0%B2%D1%96%D0%B2%D1%81%D1%8C%D0%BA%D0%B0+%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C,+%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D0%B0/@49.8404509,24.0134988,17z/data=!3m1!4b1!4m5!3m4!1s0x473add76e1c6ee3b:0xda08ff9150b3da68!8m2!3d49.8404475!4d24.0156875').first_or_create!

#=== Pages ====================================================================
puts Page.where(title: 'About',    body: '...', url: 'about').first_or_create!
puts Page.where(title: 'Contacts', body: '...', url: 'contacts').first_or_create!

public_agreement = File.join('db', 'seed', 'pages', 'public_agreement.md')
puts Page.where(url: 'public-agreement').first_or_create!(title: 'Public Agreement', body: File.read(public_agreement))

privacy_policy = File.join('db', 'seed', 'pages', 'privacy_policy.md')
puts Page.where(url: 'privacy').first_or_create!(title: 'Privacy Policy', body: File.read(privacy_policy))

#=== Email Template ===========================================================
puts Rake::Task['email_templates:seed'].execute

#=== Event ====================================================================
puts event = Event.where(
  title:          'The best pivorak ever',
  status:         :registration,
  limit_total:    5,
  limit_verified: 3,
  venue:          Venue.first,
  published:      true,
  started_at:     Time.now + 10.days,
  finished_at:    Time.now + 10.days + 3.hours
).first_or_create!

#=== Talks ====================================================================
3.times do |n|
  Talk.where(
    speaker_id:  n + 2,
    event_id:    event.id,
    title:       Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph
  ).first_or_create!
end

#=== Visit Requests ===========================================================
puts event.visit_requests.where(user: User.first,  status: :approved).first_or_create!
puts event.visit_requests.where(user: User.second, status: :pending).first_or_create!
puts event.visit_requests.where(user: User.third,  status: :canceled).first_or_create!

#=== Courses ==================================================================

puts '==== Courses seeds ===='

Courses::Engine.load_seed
