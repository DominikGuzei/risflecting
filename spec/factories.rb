FactoryGirl.define do
  factory :appointment do
    title      "What a beautiful title!"
    location   "Somewhere in Austria"
    starttime  { generate :date }
    endtime    { generate :date }
  end

  sequence :date do |n|
    n.days.from_now
  end
end
