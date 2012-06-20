require 'spec_helper'

describe Game do
  describe "#create" do
    it "should exist with a name and state" do
      game = Game.create(name: "New Game")
      game.name.should == "New Game"
    end

    it "should require a name" do
      expect { Game.create!(name: nil) }.to raise_error
    end

    it "should default the state to pending" do
      game = Game.create(name: "New Game")
      game.status.should == "pending"
    end

    it "should not create a game if one is active" do
      FactoryGirl.create(:active_game)
      expect { Game.create!(name: "Another Game") }.to raise_error
    end
  end

  describe "#pending" do
    let!(:games) { FactoryGirl.create_list(:pending_game, 10) }
    it "returns all pending games" do
      Game.pending.should == games
    end

    it "does not return a current game" do
      game = FactoryGirl.create(:active_game)
      Game.pending.should_not include(game)
    end
  end

  describe "#past_games" do
    let!(:games) { FactoryGirl.create_list(:past_game, 10) }
    it "returns all past games" do
      Game.past.should == games
    end

    it "does not return a current game" do
      game = FactoryGirl.create(:active_game)
      Game.past.should_not include(game)
    end
  end

  describe ".start" do
    let!(:game) { FactoryGirl.create(:active_game) }
    it "sets the game's status to finished" do
      game.start
      game.status.should == "active"
    end
  end

  describe ".finish" do
    let!(:game) { FactoryGirl.create(:active_game) }
    it "sets the game's status to finished" do
      game.finish
      game.status.should == "finished"
    end
  end

  describe ".current_game" do
    let!(:game) { FactoryGirl.create(:active_game) }
    it "returns the current game object" do
      game.finish
      game2 = FactoryGirl.create(:active_game)
      Game.current.should == game2
    end
  end
end
