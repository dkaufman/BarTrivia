class Api::TeamsController < ApplicationController
  respond_to :json

  def show
    respond_with(current_team)
  end

  def create
    game = Game.current
    @team = game.teams.new(params["team"])
    if @team.save
      create_cookie_for(@team)
      head :created
    else
      head :unprocessable_entity
    end
  end
end
