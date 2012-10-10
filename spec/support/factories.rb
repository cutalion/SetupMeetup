FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
  end

  factory :event do
    name        "Rails Meetup"
    time        Time.zone.local(2012, 02, 28, 18, 30, 00)
    description "Next Meetup!"
    owner { FactoryGirl.create :user }
  end

  factory :comment do
    association :owner, factory: :user
    association :event
    sequence(:body) { |n| "body #{n}" }
  end
end
