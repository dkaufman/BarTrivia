require 'spec_helper'

describe "Games API" do
  describe "/api/game" do
    let!(:game) { FactoryGirl.create(:active_game) }
    it "responds with the current game" do
      get '/api/game.json'
      response.body.should == Game.current.to_json
    end
  end
end
