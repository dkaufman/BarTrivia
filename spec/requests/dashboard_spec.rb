require 'spec_helper'

describe "Dashboard Requests" do
  describe "/dashboard" do
    context "there is no active game" do
      let!(:past_games) { FactoryGirl.create_list(:past_game, 10) }
      before(:each) { visit "/dashboard" }
      it "lists all past games" do
        Game.all.each do |game|
          page.should have_content game.name
        end
      end

      it "has a form to create a new game" do
        page.should have_selector("#new_game")
      end
    end

    context "there is an active game" do
      let!(:past_game) { FactoryGirl.create(:past_game) }
      let!(:game) { FactoryGirl.create(:game) }
      before(:each) { visit "/dashboard" }

      it "shows the current games name" do
        page.should have_content game.name
      end

      it "does not show past games" do
        page.should_not have_content past_game.name
      end
    end
  end

  describe "creating a new game" do
    before(:each) { visit "/dashboard" }
    context "with a valid name" do
      it "creates a new room" do
        fill_in :game_name, with: "Quick Game"
        click_button "Create Game"
        game = Game.last
        game.name.should == "Quick Game"
        game.status.should == "active"
      end
    end
    
    context "without a valid name" do
      it "does not create a room" do
        fill_in :game_name, with: "abc"
        expect { click_button "Create Game" }.to change { Game.count }.by(0)
      end

      it "returns the user to the same dashboard" do
        fill_in 'Name', with: "abc"
        click_button "Create Game"
        page.should have_selector("#new_game")
      end
    end
  end
end
