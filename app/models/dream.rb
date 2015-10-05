class Dream < ActiveRecord::Base
  belongs_to :user

  validates :text, presence: true
  validates :sentiment, presence: true
  validates :date, presence: true
  validates :user, presence: true

  validates :text, length: { minimum: 15 }
  validates :sentiment, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }
  validates :title, length: { maximum: 40 }, allow_blank: true

end
