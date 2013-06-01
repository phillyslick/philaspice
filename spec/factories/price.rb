FactoryGirl.define do
  factory :price do
    amount {rand(1.00..100.00)}
  end
end