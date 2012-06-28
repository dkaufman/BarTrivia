class Response < ActiveRecord::Base
  attr_accessible :body
  belongs_to :question
  belongs_to :team

  validates :body, presence: true

  def self.create_for_team_and_question(team, question, params)
    response = Response.new(params)
    response.team = team
    response.question = question
    response.save
    Waitress.announce_new_response(response)
    return response
  end

  def self.for_current_question
    Question.current.responses
  end

  def as_json(*params)
    { id: self.id, body: self.body, team: team.name, team_id: team.id}
  end

  def mark_as_correct
    self.correct = true
    save
  end
end
