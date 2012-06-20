require 'spec_helper'

describe "Player Requests" do
  describe '/' do
    let!(:game) { FactoryGirl.create(:game) }
    context "There is currently a game going on" do
      it "shows the current game's name" do
        visit "/"
        page.should have_content game.name
      end
    end
    context "There is not a game going on" do
      it "says that there is no game occuring" do
        game.finish
        visit "/"
        page.should have_content "no game"
      end
    end
  end
end
