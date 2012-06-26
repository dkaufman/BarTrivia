Question.destroy_all
Game.destroy_all

10.times do
  pending_game = FactoryGirl.create(:pending_game)
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "The first 'Electric Pig' was developed in 1927. What do we call this common household convenience invention nowadays?",
                     category: "Inventions",
                     solution: "Garbage Disposal")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "The city of Chicago gets its name from the Native American word 'Checagou,' which is the name of a vegetable. What vegetable is it?",
                     category: "Vegetables",
                     solution: "Garlic")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What franchise takes its name from the first mate on the Pequod in Herman Melville\'s 'Moby Dick'?",
                     category: "Business",
                     solution: "Starbucks")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Which founding father and first secretary of the treasury was shot dead in a duel by Thomas Jefferson\'s vice president Aaron Burr, becoming the first person shot in the face by a vice president?",
                     category: "US History",
                     solution: "Alexander Hamilton")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "On the TV show 'Seinfeld,' what fake name does George frequently use for fictional others and/or himself (first and last name)?",
                     category: "Television",
                     solution: "Art Vandaley")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What is the name of Little Orphan Annie\'s dog?",
                     category: "Fiction",
                     solution: "Sandy")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "Known as 'Mr. Dynamite,' whose back-up band on his 'Live at the Apollo' album was called the Famous Flames?",
                     category: "Music",
                     solution: "James Brown")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "In 1995, who played 'A Vampire in Brooklyn'?",
                     category: "Movies",
                     solution: "Eddie Murphy")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What cereal once offered green tree-shaped marshmallows as a promotion for Earth Day?",
                     category: "Breakfast Cereal",
                     solution: "Lucky Charms")
  FactoryGirl.create(:question, game_id: pending_game.id,
                     body: "What heavyweight boxer of the 1960s and 1970s was known as 'The Bayonne Bleeder'?",
                     category: "Sports",
                     solution: "Chuck Wepner")
end

5.times do
  past_game = FactoryGirl.create(:past_game)
  10.times do
    FactoryGirl.create(:question, game_id: past_game.id)
  end
end
