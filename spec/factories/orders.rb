FactoryBot.define do
  factory :order do
    trip { nil }
    user { nil }
    rating { 1 }
    review { "MyText" }
    price { 1 }
  end
end
