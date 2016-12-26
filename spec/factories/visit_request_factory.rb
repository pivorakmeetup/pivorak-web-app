FactoryGirl.define do
  factory :visit_request do
    event
    user
    status VisitRequest::PENDING
  end
end
