FactoryGirl.define do
  factory :visit_request do
    event
    user
    status VisitRequest::PENDING

    trait :visited do
      visited true
    end
  end
end
