FactoryGirl.define do
  factory :customer do
    sequence :first_name {|n| "Timothy #{n}"}
    sequence :last_name {|n| "Smith #{n}"}
  end
end
