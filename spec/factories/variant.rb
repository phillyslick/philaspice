FactoryGirl.define do
  factory :variant do
    sku '345-98765-0987'
    product { |v| v.association(:product) }
    deleted_at nil
    master false
    name { Faker::Name.name}
    description { Faker::Lorem.paragraphs(2)}
    stocked false
  end
end
