FactoryGirl.define do
  factory :variant do
    sku '345-98765-0987'
    product { |v| v.association(:product) }
    price 10.00
    deleted_at nil
    master false
    name { Faker::Name.name}
  end
end