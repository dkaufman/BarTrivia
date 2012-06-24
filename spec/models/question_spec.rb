require 'spec_helper'

describe Question do
  it "belongs to a game" do
    question = FactoryGirl.create(:question)
    question.game
  end

  describe ".already_asked?" do
    let(:question) { FactoryGirl.create(:question) }
    it "returns true if asked == true" do
      question.asked = true
      question.save
      question.already_asked?.should be_true
    end
    it "returns false if asked != true" do
      question.already_asked?.should be_false
    end
  end

  describe "#ask_next" do
    let(:game) { FactoryGirl.create(:active_game_with_questions) }
    before(:each) do
      first_question = game.questions.first
      first_question.asked = true
      first_question.save
    end
    it "returns the first unasked question in the current game" do
      Question.ask_next.should == game.questions.all[1]
    end

    it "sets the returned question's 'asked' value to true" do
      Question.ask_next.asked.should == true
    end
  end
end
