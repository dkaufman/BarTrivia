require 'spec_helper'

describe Team do
  describe "#create" do
    let!(:game) { FactoryGirl.create(:active_game) }
    it "creates a unique token for each team" do
      team1 = game.teams.create(name: "Cool Kids")
      team2 = game.teams.create(name: "Jocks")
      team1.token.should_not be_nil
      team2.token.should_not be_nil
      team1.token.should_not == team2.token
    end
  end

  describe "#for_current_game" do
    it "returns an array of teams for that current game" do
      game = FactoryGirl.create(:active_game)
      teams = FactoryGirl.create_list(:team, 5, game_id: game.id)
      Team.for_current_game.should == teams
    end
  end

  describe ".points" do
    it "returns the count of the teams correct responses" do
      team = FactoryGirl.create(:team)
      incorrect_responses = FactoryGirl.create_list(:response, 3, team_id: team.id)
      correct_responses = FactoryGirl.create_list(:response, 2, team_id: team.id, correct: true)

      team.points.should == 2
    end
  end
end
