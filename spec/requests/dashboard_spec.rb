require 'spec_helper'

describe "Dashboard Requests" do
  describe "visiting the /dashboard" do
    context "when there is no active game" do
      let!(:past_games) { FactoryGirl.create_list(:past_game, 10) }
      before(:each) { visit "/dashboard" }
      it "lists all past games" do
        past_games.each do |game|
          page.should have_content game.name
        end
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

      it "displays an error on the form" do
        fill_in 'Name', with: "abc"
        click_button "Create Game"
        page.should have_selector("#new_game")
        page.should have_content("too short")
      end
    end
  end

  describe "starting a game" do
    let!(:game) { FactoryGirl.create(:pending_game) }
    before(:each) do
      visit "/dashboard"
      Waitress.stub(:announce_new_game)
      click_link "game_#{game.id}_start"
    end
    it "changes the game's status to active" do
      game.reload.status.should == "active"
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
      game.reload.status.should == "finished"
    end
    it "redirects to the dashboard" do
      current_path.should == dashboard_path
    end
  end

  describe "adding questions to a game" do
    let!(:game) { FactoryGirl.create(:pending_game) }
    before(:each) do
      visit "/dashboard"
      click_link "game_#{game.id}_add_question"
    end

    context "with valid information" do
      before(:each) do
        fill_in "Category", with: "Names"
        fill_in "Question", with: "What is your name?"
        fill_in "Solution", with: "Dan"
      end
      it "creates a new question for that game" do
        expect { click_button "Create Question" }.to change { game.questions.count }.by(1)
      end

      it "increases the question count next to the game" do
        click_button "Create Question"
        within("#game_#{game.id}_question_count") do
          page.should have_content("1")
        end
      end
    end

    context "with invalid information" do
      it "raises an error on the form" do
        fill_in "Category", with: ""
        fill_in "Question", with: ""
        fill_in "Solution", with: ""
        click_button "Create Question"
        page.should have_content "can't be blank"
      end
    end
  end
end
