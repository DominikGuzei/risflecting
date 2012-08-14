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
    phone                 "+436642312342"
    password              "password"
    password_confirmation "password"
    confirmed_at          Time.now
    roles                 { [ Role.find_or_create_by_name('Member') ] }
  end

  factory :admin, :parent => :user do
    roles { [ Role.find_or_create_by_name('Admin') ] }
  end

  factory :post do
    title "A superb title"
    body  "I have some big problems and I have no clue how to solve them. Please help."
  end

  sequence :date do |n|
    n.days.from_now
  end

  sequence :email do |n|
    "tester#{n}@test.com"
  end
end
