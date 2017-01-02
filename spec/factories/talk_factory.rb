FactoryGirl.define do
  factory :talk do
    title       Faker::Lorem.word
    description Faker::Lorem.paragraph
    video_url   Faker::Internet.url('youtube.com')
    slides_url  Faker::Internet.url('slideshare.net')
    published   true
  end
end
