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
      context "the player has already created a team name" do
        it "shows the waiting for next question screen" do
          visit "/"
          page.should have_selector "#waiting"
          page.should have_content game.name
        end
      end
    end
    context "There is not a game going on" do
      it "says that there is no game occuring" do
        game.finish
        visit "/"
        save_and_open_page
        page.should have_selector "#no_game"
        page.should have_content "No Current Game"
      end
    end
  end

  describe 'starting a game while the user is on the root path' do
    it "shows the waiting for next question screen" do
      pending "Testing Pusher"
      page.should have_selector "#waiting"
    end
  end

  describe 'creating a team name' do
    context "with a valid team name" do
      let!(:game) { FactoryGirl.create(:active_game) }
      before(:each) do
        visit "/"
        fill_in "Name", with: "Cool Kids"
        click_button "Create Team"
      end
      it "shows the waiting for next question screen" do
        page.should have_selector "#waiting"
      end

      it "shows the team name" do
        page.should have_content Team.last.name
      end
    end
  end
end
