require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "testuser#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :dream do
    title "It's raining dogs"
    text "One day I woke up and there was a hurricane of dogs. It was pretty strange, all things considered."
    date "10-05-2015"
    sentiment "0.89"
    user
  end
end
