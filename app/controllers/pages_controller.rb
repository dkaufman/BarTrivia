class PagesController < ApplicationController
  def home
    @team = Team.new
    @response = Response.new
  end
end
