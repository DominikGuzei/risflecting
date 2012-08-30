FactoryGirl.define do
  factory :appointment do
    title         "What a beautiful title!"
    location      "Somewhere in Austria"
    starttime     { generate :date }
    endtime       { generate :date }
  end

  factory :user, :aliases => [:author, :uploader] do
    email                 { generate :email }
    forename              { generate :forename }
    surname               { generate :surname }
    phone                 "+436642312342"
    password              "password"
    password_confirmation "password"
    confirmed_at          Time.now
    current_sign_in_at    Time.now
    last_sign_in_at       Time.now
    role                  { Role.find_or_create_by_name 'Member' }
  end

  factory :admin, :parent => :user do
    role  { Role.find_or_create_by_name 'Admin' }
  end

  factory :coordinator, :parent => :user do
    role  { Role.find_or_create_by_name 'Coordinator' }
  end

  factory :question do
    title   "A superb title"
    body    "I have some big problems and I have no clue how to solve them. Please help."
    author
  end

  factory :project do
    title   "A bombastic title"
    body    "I have some lovely project experiences which I want to share with you."
    author
  end

  factory :comment do
    text    "A comment text"
    author
  end

  factory :appointment_response do
    association :user, :factory => :user, :strategy => :build
    association :appointment, :factory => :appointment, :strategy => :build
    accepted    { true }
  end

  factory :attachment do
    association :attachable, :factory => :question, :strategy => :build
    file        { File.open "#{Rails.root}/features/fixtures/test.png" }
  end

  factory :document do
    title       { generate :title }
    asset       { File.open "#{Rails.root}/features/fixtures/test.png" }
    uploader
  end

  sequence(:date)     { |n| n.days.from_now }
  sequence(:email)    { |n| "tester#{n}@test.com" }
  sequence(:forename) { |n| "Marvin#{n}" }
  sequence(:surname)  { |n| "Hubot#{n}" }
  sequence(:title)    { |n| "Random title #{n}" }
end
