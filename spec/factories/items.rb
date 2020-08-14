FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    price { Faker::Number.number(digits: 7) }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 2..11) }
    status_id { Faker::Number.within(range: 2..7) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    shipping_cost_id { Faker::Number.within(range: 2..3) }
    shipping_day_id { Faker::Number.within(range: 2..4) }
    association :user
  end
end
