class Question < ActiveRecord::Base
  attr_accessible :body, :solution, :category
  belongs_to :game

  validates :category, presence: true
  validates :body, presence: true
  validates :solution, presence: true

end
