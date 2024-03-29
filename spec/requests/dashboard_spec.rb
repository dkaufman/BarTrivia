require 'spec_helper'

describe "Dashboard Requests" do
  before(:each) { DashboardsController.any_instance.stub(:authenticate) }
  describe "visiting the /dashboard" do
    context "when there is no active game" do
      let!(:pending_games) { FactoryGirl.create_list(:pending_game, 10) }
      before(:each) { visit "/dashboard" }
      it "lists all pending games" do
        pending_games.each do |game|
          page.should have_content game.name
        end
      end
    end

    context "there is an active game" do
      let!(:past_game) { FactoryGirl.create(:past_game) }
      let!(:game) { FactoryGirl.create(:active_game) }
      before(:each) { visit "/dashboard" }

      it "show the game screen" do
        page.should have_content "Questions Remaining"
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
        fill_in 'game_name', with: "Quick Game"
        click_button "Create New Game"
        game = Game.last
        game.name.should == "Quick Game"
        game.status.should == "pending"
      end
    end

    context "without a valid name" do
      it "does not create a game" do
        fill_in 'game_name', with: "abc"
        expect { click_button "Create New Game" }.to change { Game.count }.by(0)
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
      Waitress.stub(:announce_game_end)
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
        fill_in "Question", with: ""
        fill_in "Solution", with: ""
        click_button "Create Question"
        page.should have_content "can't be blank"
      end
    end
  end
end

describe "In-Game View", js: true do
  let!(:game) { FactoryGirl.create(:active_game_with_questions) }
  before(:each) do
    DashboardsController.any_instance.stub(:authenticate)
    visit "/dashboard"
  end

  describe "clicking 'Ask Next Question'" do
    before(:each) do
      Waitress.stub(:announce_new_question)
      click_link "next_question"
    end

    it "reveals the next question" do
      page.should have_content game.questions.first.body
    end

    it "does not show the answer" do
      page.should_not have_content game.questions.first.solution
    end
  end

  describe "clicking 'Times Up'", js: true do
    before(:each) do
      Waitress.stub(:announce_new_question)
      Waitress.stub(:announce_times_up)
      click_link "next_question"
      sleep(0.1)
      click_link "times_up"
      sleep(0.1)
    end

    it "shows the answer to the question" do
      page.should have_content game.questions.first.solution
    end
  end
end
