require 'alchemyapi'

class Dream < ActiveRecord::Base
  belongs_to :user

  validates :text, presence: true
  validates :sentiment, presence: true
  validates :date, presence: true
  validates :user, presence: true

  validates :text, length: { minimum: 15 }
  validates :sentiment, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }
  validates :title, length: { maximum: 40 }, allow_blank: true

  # validate :dream_date_cannot_be_in_the_future

  # def dream_date_cannot_be_in_the_future
  #   if :date > Date.today
  #     errors.add(:date, "can't be in the future")
  #   end
  # end

  def get_sentiment
    alchemyapi = AlchemyAPI.new()
    response = alchemyapi.sentiment('text', self.text, { 'sentiment'=>1 })

    if response['status'] == 'OK'
      sentiment = response['docSentiment']['score']
    else
      puts 'Error in sentiment extraction call: ' + response['statusInfo']
    end
  end

  def keywords
    alchemyapi = AlchemyAPI.new()
    response = alchemyapi.keywords('text', self.text, { 'sentiment'=>1 })

    if response['status'] == 'OK'
    	keywords = response['keywords']
    else
    	puts 'Error in keyword extraction call: ' + response['statusInfo']
    end
  end
end