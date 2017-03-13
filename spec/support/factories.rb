FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "#{n} New Homes for Sale!" }
    sequence(:author) { |n| "Realtor No. #{n}" }
    body "Schedule a visit today to see if one of these beautiful new homes is
          right for you."
  end
end
