class Api::ResponsesController < ApplicationController
  respond_to :json

  def create
    game = Game.current
    team = current_team
    @response = Response.create_for_team_and_question(current_team, Question.current, params[:response])
    if @response.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  def show
    @response = Response.find(params[:id])
    respond_with(@response)
  end

  def correct
    response = Response.find(params[:id])
    response.mark_as_correct
    head :ok
  end
end
