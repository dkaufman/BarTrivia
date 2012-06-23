class ApplicationController < ActionController::Base
  protect_from_forgery

  def create_cookie_for(team)
    key = Game.current_cookie_key
    cookies[key] = team.token
  end

  def current_team
    Team.find_by_token(cookies[Game.current_cookie_key])
  end
end
