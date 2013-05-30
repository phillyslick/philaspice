FactoryGirl.define do
  factory :product do
    name {Faker::Name.first_name}
    description {Faker::Lorem.sentences(2)}
    deleted_at nil
    featured true
    base_price 9.99
  end
end