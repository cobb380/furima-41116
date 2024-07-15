# spec/factories/order_addresses.rb
FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture { 3 }
    city { '渋谷区' }
    house_number { '1-2-3' }
    phone_number { '09012345678' }
    building_name { '建物名' }
  end
end