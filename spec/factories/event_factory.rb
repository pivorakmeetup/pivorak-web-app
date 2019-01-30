FactoryBot.define do
  factory :event do
    title       { Faker::Lorem.word }
    agenda      { Faker::Lorem.paragraph }
    status      { Event::REGISTRATION }
    published   { true }
    started_at  { Time.now }
    finished_at { Time.now }

    trait :planned do
      status      { Event::PLANNED }

      started_at  { Time.now + 3.days }
      finished_at { nil }
    end

    trait :live_now do
      status      { Event::LIVE }

      started_at  { Time.now - 10.minutes }
      finished_at { nil }
    end

    factory :event_with_talks do
      transient do
        talks_count { 3 }
      end

      after(:create) do |event, evaluator|
        evaluator.talks_count.times do
          event.talks << create(:talk)
        end
      end
    end
  end
end
