FactoryGirl.define do
  factory :game do
    sequence(:name) { |n| "game_#{n}" }
  end

  factory :pending_game, parent: :game

  factory :active_game, parent: :game do
    status "active"
  end

  factory :past_game, parent: :game do
    status "finished"
  end

  factory :active_game_with_questions, parent: :active_game do
    after(:create) do |game, evaluator|
      FactoryGirl.create_list(:question, 10, game_id: game.id)
    end
  end
end
