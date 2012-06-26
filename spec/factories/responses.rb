# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
    sequence(:body) { |n| "body_#{n}" }
    sequence(:team_id) { |n| n }
    sequence(:question_id) { |n| n }
    correct false
  end
end
