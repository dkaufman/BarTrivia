class TeamsController < ApplicationController
  def create
    game = Game.current
    @team = game.teams.new(params[:team])
    if @team.save
      create_cookie_for(@team)
      redirect_to root_path
    else
      render "pages/home"
    end
  end
end
