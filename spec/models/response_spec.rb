require 'spec_helper'

describe Response do
  it "belongs to a team" do
    team = FactoryGirl.create(:team)
    response = FactoryGirl.create(:response, team_id: team.id)
    response.team
  end

  it "belongs to a question" do
    question = FactoryGirl.create(:question)
    response = FactoryGirl.create(:response, question_id: question.id)
    response.question
  end

  describe "#create_for_team_and_question" do
    let(:params) { { body: "Answer to Question" } }
    let(:question) { FactoryGirl.create(:question) }
    let(:team) { FactoryGirl.create(:team) }
    it "creates a response with the appropriate team id and question id" do
      Response.create_for_team_and_question(team, question, params)
      response = Response.last
      response.body.should == "Answer to Question"
      response.question.should == question
      response.team.should == team
    end

    it "announces the response with Waitress" do
      Waitress.should_receive(:announce_new_response)
      Response.create_for_team_and_question(team, question, params)
    end
  end
end
