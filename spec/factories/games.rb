FactoryGirl.define do
  factory :game do
    sequence(:name) { |n| "game_#{n}" }
  end

  factory :past_game, class: :game do
    sequence(:name) { |n| "game_#{n}" }
    status "finished"
  end
end
