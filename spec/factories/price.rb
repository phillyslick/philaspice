FactoryGirl.define do
  factory :price do
    amount {rand(1.00..100.00)}
    variant { |p| p.association(:variant) }
    weight { |p| p.association(:weight) }
  end
end