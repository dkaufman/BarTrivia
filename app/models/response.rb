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
    Question.current.responses.select { |response| !response.correct }
  end

  def self.number_correct
    Question.current.responses.select { |response| response.correct }.count
  end

  def self.auto_grade
    Question.current.responses.each do |response|
      response.mark_as_correct if response.can_auto_confirm?
    end
  end

  def as_json(*params)
    { id: self.id, body: self.body, team: team.name, team_id: team.id}
  end

  def mark_as_correct
    self.correct = true
    save
  end

  def can_auto_confirm?
    Question.current.solution.casecmp(body) == 0
  end
end
