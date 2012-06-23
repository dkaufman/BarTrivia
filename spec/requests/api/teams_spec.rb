require 'spec_helper'

describe "Teams API" do
  describe "/api/team" do
    let!(:game) { FactoryGirl.create(:active_game) }
    let!(:controller) { mock(ApplicationController) }
    it "responds with the current team" do
      team = game.teams.create(name: "New Team")
      controller.stub(:current_team).and_return(team)
      get '/api/team.json'
      pending
    end
  end
end
