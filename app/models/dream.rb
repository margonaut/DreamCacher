class Dream < ActiveRecord::Base
  belongs_to :user
  has_many :dreams_keywords
  has_many :keywords, through: :dreams_keywords

  validates :user, presence: true
  validates :text, presence: true
  validates :text, length: { minimum: 15 }
  validates :sentiment, presence: true
  validates :sentiment, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }
  validates :date, presence: true
  validates :title, length: { maximum: 40 }, allow_blank: true
  validates :mixed, inclusion: { in: [true, false] }

  def snippet
    length = 70
    if text.length < length
      text
    else
      "#{text[0..length]}..."
    end
  end

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
