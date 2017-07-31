FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'example@user.com'
    admin true
  end
end
