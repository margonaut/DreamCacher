require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "testuser#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
