FactoryBot.define do
  factory :order_delivery do
    user_id { "1" }
    item_id { "1" }
    token { "tok_abcdefghijk00000000000000000" }
    post_code {"123-4567"}
    prefecture_id {Faker::Number.between(from: 2, to:48)}
    city { "東京都" }
    street { "1-1" }
    building { "東京ハイツ" }
    phone_number {"01234567890"}
  end
end