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
end
