FactoryGirl.define do
  factory :appointment do
    title         "What a beautiful title!"
    location      "Somewhere in Austria"
    starttime     { generate :date }
    endtime       { generate :date }
  end

  factory :user do
    email                 { generate :email }
    forename              "Marvin"
    surname               "Hubot"
    phone                 "0664 12 43 343"
    password              "password"
    password_confirmation "password"
    confirmed_at          Time.now
  end

  sequence :date do |n|
    n.days.from_now
  end

  sequence :email do |n|
    "tester#{n}@test.com"
  end
end
