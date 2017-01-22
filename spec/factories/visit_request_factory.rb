FactoryGirl.define do
  factory :visit_request do
    event
    user
    status VisitRequest::PENDING

    trait :final do
      status VisitRequest::APPROVED
      visited { true }
    end

  end
end
