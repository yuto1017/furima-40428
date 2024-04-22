FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials}
    email {Faker::Internet.unique.email}
    password {Faker::Internet.password(min_length: 6) + '1a'}
    password_confirmation {password}
    last_name {'山田'}
    first_name {'陸太'}
    last_name_kana {'ヤマダ'}
    first_name_kana {'リクタ'}
    birthday {Faker::Date.birthday}
  end
end