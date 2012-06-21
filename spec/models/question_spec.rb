require 'spec_helper'

describe Question do
  it "belongs to a game" do
    question = FactoryGirl.create(:question)
    question.game
  end
end
