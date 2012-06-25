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
        before(:each) do
          visit "/"
          fill_in "team_name", with: "Cool Kids"
          click_button "Create Team"
          wait_until { page.find("#waiting").visible? }
        end
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
        page.should have_selector "#no_game"
        page.should have_content "No Current Game"
      end
    end
  end

  describe 'starting a game while the user is on the root path' do
    it "shows the waiting for next question screen" do
      pending "How to test pusher?"
      page.should have_selector "#waiting"
    end
  end

  describe 'creating a team name' do
    let!(:game) { FactoryGirl.create(:active_game) }
    context "with a valid team name" do
      it "shows the waiting for next question screen" do
        visit "/"
        fill_in "team_name", with: "Cool Kids"
        click_button "Create Team"
        page.should have_selector "#waiting"
      end
    end
    context "with an invalid team name" do
      let!(:game) { FactoryGirl.create(:active_game) }
      it "returns to the form with an error" do
        pending "client side validation"
        visit "/"
        fill_in "team_name", with: ""
        click_button "Create Team"
        page.should have_selector "#new_team_form"
        page.should have_content "can't be blank"
      end
    end
  end
end
