FactoryBot.define do
  factory :menu_item, class: Menu::Item do
    label        Faker::Name.name
    href         Faker::Internet.url
  end
end
