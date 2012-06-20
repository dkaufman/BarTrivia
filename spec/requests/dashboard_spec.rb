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
      let!(:game) { FactoryGirl.create(:active_game) }
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
      it "creates a new game" do
        fill_in :game_name, with: "Quick Game"
        click_button "Create Game"
        game = Game.last
        game.name.should == "Quick Game"
        game.status.should == "pending"
      end
    end
    
    context "without a valid name" do
      it "does not create a game" do
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

  describe "starting a game" do
    let!(:game) { FactoryGirl.create(:pending_game) }
    before(:each) do
      visit "/dashboard"
      click_link "game_#{game.id}_start"
    end
    it "changes the game's status to active" do
      Game.find(game.id).status.should == "active"
    end
    it "redirects to the dashboard" do
      current_path.should == dashboard_path
    end
  end

  describe "finishing a game" do
    let!(:game) { FactoryGirl.create(:active_game) }
    before(:each) do 
      visit "/dashboard"
      click_link "End Game"
    end
    it "changes the game's status to finished" do
      Game.find(game.id).status.should == "finished"
    end
    it "redirects to the dashboard" do
      current_path.should == dashboard_path
    end
  end
end
