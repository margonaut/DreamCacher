require 'alchemyapi'

class Dream < ActiveRecord::Base
  after_save :dream_analysis, if: :text_changed?
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

  def dream_analysis
    alchemyapi = AlchemyAPI.new
    keyword_response = alchemyapi.keywords('text', text, 'sentiment' => 1)
    sentiment_response = alchemyapi.sentiment('text', text, 'sentiment' => 1 )
    if sentiment_response['status'] == 'OK' && keyword_response['status'] == 'OK'
      update_sentiment(sentiment_response)
      update_keywords(keyword_response)
    else
      puts 'Error in extraction call: ' + keyword_response['statusInfo']
    end
  end

  private

  def update_sentiment(response)
    new_sentiment = response['docSentiment']['score']
    update_columns(sentiment: new_sentiment)
  end

  def update_keywords(response)
    old_keywords = dreams_keywords
    dreams_keywords.destroy(old_keywords)
    keywords = response['keywords']
    keywords.each do |keyword|
      word = Keyword.find_or_create_by(text: keyword["text"])
      keyword["mixed"].nil? ? mixed = false : mixed = true
      relevance = keyword["relevance"]
      sentiment = keyword["sentiment"]["score"]
      DreamsKeyword.create(dream: self,
                           keyword: word,
                           relevance: relevance,
                           sentiment: sentiment,
                           mixed: mixed)
    end
  end
end
