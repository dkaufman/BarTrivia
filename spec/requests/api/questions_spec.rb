require 'spec_helper'

describe "Questions API" do
  describe "/api/question", js: true do
    let!(:game) { FactoryGirl.create(:active_game_with_questions) }
    before(:each) do
      Waitress.stub(:announce_new_question)
      get '/api/question.json'
    end

    it "responds with the next question" do
      response.body.should == game.questions.first.to_json
    end
  end
end
