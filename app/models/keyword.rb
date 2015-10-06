require 'alchemyapi'

class Keyword < ActiveRecord::Base
  has_many :dreams_keywords
  has_many :dreams, through: :dreams_keywords

  validates :text, presence: true
  validates :text, uniqueness: true
end
