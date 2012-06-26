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
      Waitress.stub(:announce_new_question)
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

    it "announces the new question through Waitress" do
      Waitress.should_receive(:announce_new_question)
      Question.ask_next
    end
  end

  describe "#last?" do
    context "there are no unasked questions for that game" do
      let!(:game) { FactoryGirl.create(:active_game) }
      it "returns true" do
        Question.last?.should be_true
      end
    end

    context "there are unasked questions for that game" do
      let!(:game) { FactoryGirl.create(:active_game_with_questions) }
      it "returns false" do
        Question.last?.should be_false
      end
    end
  end

  describe "#current" do
    let!(:game) { FactoryGirl.create(:active_game_with_questions) }
    before(:each) { Waitress.stub(:announce_new_question) }
    it "returns the current question" do
      current_question = Question.ask_next
      Question.current.should == current_question
    end
  end

  describe ".mark_as_asked" do
    it "sets asked to true" do
      question = FactoryGirl.create(:question)
      question.mark_as_asked
      question.asked.should be_true
    end
  end

  describe "#times_up" do
    it "announces times up through Waitress" do
      Waitress.should_receive(:announce_times_up)
      Question.times_up
    end
  end
end
