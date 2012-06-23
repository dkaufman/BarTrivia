class Api::TeamsController < ApplicationController
  respond_to :json

  def show
    respond_with(current_team)
  end
end
