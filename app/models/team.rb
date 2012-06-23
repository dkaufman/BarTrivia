class Team < ActiveRecord::Base
  attr_accessible :name
  belongs_to :game

  before_validation :create_token, on: :create
  validates :name, presence: true, length: { in: 5..100 }
  validates_presence_of :name, :game_id, :token

  protected

  def create_token
    self.token = rand(36**8).to_s(36)
  end
end
