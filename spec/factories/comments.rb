FactoryBot.define do
  factory :comment do
    text { 'あいうえお' }
    association :item
    user { item.user }
  end
end
