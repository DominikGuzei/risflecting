FactoryGirl.define do
  factory :appointment do
    title         "What a beautiful title!"
    location      "Somewhere in Austria"
    starttime     { generate :starttime }
    endtime       { generate :endtime }
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

  sequence :starttime do |n|
    n.days.from_now
  end

  sequence :endtime do |n|
    (n + 1).days.from_now
  end

  sequence :email do |n|
    "tester#{n}@test.com"
  end
end
