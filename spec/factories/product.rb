FactoryGirl.define do
  factory :product do
    name {Faker::Name.first_name}
    description {Faker::Lorem.sentences(2)}
    deleted_at nil
    featured true
    temp_price 9.94
    category { |p| p.association(:category) }
  end
end