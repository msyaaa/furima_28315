FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    gimei = Gimei.name
    last_name {gimei.last.kanji}
    first_name {gimei.first.kanji}
    last_name_reading {gimei.last.katakana}
    first_name_reading {gimei.first.katakana}
    birthday {Faker::Date.in_date_period}
  end
end