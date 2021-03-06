require 'alchemyapi'

class DreamsKeyword < ActiveRecord::Base
  belongs_to :dream
  belongs_to :keyword

  validates :dream, presence: true
  validates :keyword, presence: true

  validates :relevance, presence: true
  validates :relevance, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }

  validates :sentiment, presence: true
  validates :sentiment, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }

  validates :mixed, inclusion: { in: [true, false] }

  def positivity
    if mixed?
      "mixed"
    elsif sentiment.to_f > 0
      "positive"
    elsif sentiment.to_f < 0
      "negative"
    elsif sentiment.to_f == 0
      "neutral"
    else
      "problem"
    end
  end
end
