# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    sequence(:first_name) { |n| "Called_#{n}" }
    last_name "Beethoven"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "password"
    role User.roles[:user]
    admin false
  end

  factory :approver, parent: :user do
    role User.roles[:approver]
  end

  factory :owner, parent: :user do
    role User.roles[:owner]
  end

  factory :admin, class: User do
    confirmed_at Time.now
    first_name Admin
    last_name "Administrator"
    email 'admin@example.com'
    password "password"
    role User.roles[:owner]
    admin true    
  end

end
