class Api::TeamsController < ApplicationController
  respond_to :json

  def all
    respond_with(Team.for_current_game)
  end

  def show
    respond_with(current_team)
  end

  def create
    game = Game.current
    @team = game.teams.new(params["team"])
    if @team.save
      create_cookie_for(@team)
      Waitress.announce_new_team
      head :created
    else
      head :unprocessable_entity
    end
  end
end
