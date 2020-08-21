FactoryBot.define do
  factory :item_purchase do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '大阪府' }
    house_number { '1-1' }
    building_name { '大阪ハイツ' }
    telephone_number { Faker::Number.number(digits: 11) }
    token { 'abcdefg' }
  end
end
