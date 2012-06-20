FactoryGirl.define do
  factory :pending_game, class: :game do
    sequence(:name) { |n| "game_#{n}" }
  end

  factory :active_game, class: :game do
    sequence(:name) { |n| "game_#{n}" }
    status "active"
  end

  factory :past_game, class: :game do
    sequence(:name) { |n| "game_#{n}" }
    status "finished"
  end
end
