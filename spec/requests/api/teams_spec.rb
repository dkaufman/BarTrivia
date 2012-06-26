require 'spec_helper'
# require "rack/test"

describe "Teams API" do
  describe "/api/team", js: true do
    let!(:game) { FactoryGirl.create(:active_game) }
    before(:each) do
      # visit "/"
      # fill_in "team_name", with: "Cool Kids"
      # click_button "Create Team"
    end
    it "responds with the current team" do
      pending "Not tracking cookies"
      # get '/api/team.json'
      # raise response.body.inspect
    end
  end
end
