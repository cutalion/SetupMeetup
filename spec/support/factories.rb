FactoryGirl.define do
  factory :user do
    password              "password"
    password_confirmation "password"
    sequence(:email) {|n| "person#{n}@example.com" }
  end

  factory :authorization do
    user_id 1
    provider "MyString"
    uid "MyString"
    token "MyString"
  end
end
