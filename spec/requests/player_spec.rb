require 'spec_helper'

describe "Player Requests", js: true do
  describe 'a user visits the root path' do
    let!(:game) { FactoryGirl.create(:active_game) }
    context "There is currently a game going on" do
      context "the player has not created a team name for that game" do
        it "asks the user to create a team name" do
          visit "/"
          page.should have_selector "#new_team_form"
        end
      end
    end
    context "There is not a game going on" do
      before(:each) { Waitress.stub(:announce_game_end) }
      it "says that there is no game occuring" do
        game.finish
        visit "/"
        page.should have_selector "#no_game"
      end
    end
  end
end
