# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "team_#{n}" }
    sequence(:game_id) { |n| "team_#{n}" }
  end
end
