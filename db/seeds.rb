Question.destroy_all
Game.destroy_all

3.times do
  pending_game = FactoryGirl.create(:pending_game, name: "#{Date.today + rand(30)} Speakeasy Trivia")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "The first 'Electric Pig' was developed in 1927. What do we call this common household convenience invention nowadays?",
                     solution: "Garbage Disposal")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "The city of Chicago gets its name from the Native American word 'Checagou,' which is the name of a vegetable. What vegetable is it?",
                     solution: "Garlic")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What franchise takes its name from the first mate on the Pequod in Herman Melville\'s 'Moby Dick'?",
                     solution: "Starbucks")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Which founding father and first secretary of the treasury was shot dead in a duel by Thomas Jefferson\'s vice president Aaron Burr, becoming the first person shot in the face by a vice president?",
                     solution: "Alexander Hamilton")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "On the TV show 'Seinfeld,' what fake name does George frequently use for fictional others and/or himself (first and last name)?",
                     solution: "Art Vandaley")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What is the name of Little Orphan Annie\'s dog?",
                     solution: "Sandy")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Known as 'Mr. Dynamite,' whose back-up band on his 'Live at the Apollo' album was called the Famous Flames?",
                     solution: "James Brown")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "In 1995, who played 'A Vampire in Brooklyn'?",
                     solution: "Eddie Murphy")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What cereal once offered green tree-shaped marshmallows as a promotion for Earth Day?",
                     solution: "Lucky Charms")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What heavyweight boxer of the 1960s and 1970s was known as 'The Bayonne Bleeder'?",
                     solution: "Chuck Wepner")
end

2.times do
  pending_game = FactoryGirl.create(:pending_game, name: "#{Date.today + rand(30)} Speakeasy Trivia")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "First Question?",
                     solution: "First Answer")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Second Question?",
                     solution: "Second Answer")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Third Question?",
                     solution: "Third Answer")
end
