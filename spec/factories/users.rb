FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    first_name "Ludwig"
    last_name "Beethoven"
    email "test@example.com"
    password "please123"
    admin false
  end
end
