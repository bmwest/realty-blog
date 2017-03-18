FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password "password"
    password_confirmation "password"
  end

  factory :article do
    sequence(:title) { |n| "#{n} New Homes for Sale!" }
    body "Schedule a visit today to see if one of these beautiful new homes is
          right for you."
  end
end
