FactoryBot.define do
  factory :item do
    name { "abc" }
    price { 11111 }
    description { "abcdefg" }
    category_id { 2 }
    status_id { 2 }
    prefecture_id { 2 }
    shipping_cost_id { 2 }
    shipping_day_id { 2 }
    association :user
  end
end
