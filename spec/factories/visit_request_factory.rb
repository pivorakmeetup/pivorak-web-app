FactoryBot.define do
  factory :visit_request do
    event
    user
    status VisitRequest::PENDING

    trait :final do
      status VisitRequest::APPROVED
      visited { true }
    end

    trait :visited do
      visited true
    end

    trait :pending do
      status VisitRequest::PENDING
    end

    trait :approved do
      status VisitRequest::APPROVED
    end

    trait :refused do
      status VisitRequest::REFUSED
    end

    trait :canceled do
      status VisitRequest::CANCELED
    end

    trait :confirmed do
      status VisitRequest::CONFIRMED
    end
  end
end
