Question.destroy_all
Game.destroy_all

10.times do
  pending_game = FactoryGirl.create(:pending_game)
  10.times do
    FactoryGirl.create(:question, game_id: pending_game.id)
  end
end

5.times do
  past_game = FactoryGirl.create(:past_game)
  10.times do
    FactoryGirl.create(:question, game_id: past_game.id)
  end
end
