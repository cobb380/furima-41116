# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    association :user
    name { Faker::Commerce.product_name }
    explanation { Faker::Lorem.sentence }
    category_id { 2 } # 1以外の有効な値を設定
    condition_id { 2 } # 1以外の有効な値を設定
    postage_id { 2 } # 1以外の有効な値を設定
    prefecture_id { 2 } # 1以外の有効な値を設定
    until_shipping_id { 2 } # 1以外の有効な値を設定
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
