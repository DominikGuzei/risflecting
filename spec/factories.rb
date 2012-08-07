FactoryGirl.define do
  factory :appointment do
    title      "What a beautiful title!"
    starttime  { generate :date }
    endtime    { generate :date }
  end

  sequence :date do |n|
    n.days.from_now
  end
end
