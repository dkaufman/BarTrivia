# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:category) { |n| "category_#{n}" }
    sequence(:body) { |n| "body_#{n}" }
    sequence(:solution) { |n| "solution_#{n}" }
    sequence(:game_id) { |n| n }
  end
end
