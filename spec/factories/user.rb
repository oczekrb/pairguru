FactoryBot.define do
  factory :user do
    email "user@example.com"
    password "password"
    confirmed_at Time.current
    name "John Smith"
  end
end
