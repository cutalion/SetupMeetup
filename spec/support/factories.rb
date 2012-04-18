FactoryGirl.define do
  factory :user do
    password              "password"
    password_confirmation "password"
    sequence(:email) {|n| "person#{n}@example.com" }
  end

  factory :authorization do
    user_id   1
    provider  "MyString"
    uid       "MyString"
    token     "MyString"
  end

  factory :event do
    name        "Rails Meetup"
    date        1.day.from_now
    time        "18:30"
    description "Next Meetup!"
    owner { FactoryGirl.create :user }
  end
end
