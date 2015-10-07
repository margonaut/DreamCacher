require 'alchemyapi'

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

  def positivity
    if self.mixed?
      "mixed"
    elsif self.sentiment.to_f > 0
      "positive"
    elsif self.sentiment.to_f < 0
      "negative"
    elsif self.sentiment.to_f == 0
      "neutral"
    else
      "problem"
    end
  end

  def get_sentiment
    alchemyapi = AlchemyAPI.new
    response = alchemyapi.sentiment('text', self.text, { 'sentiment'=>1 })

    if response['status'] == 'OK'
      sentiment = response['docSentiment']['score']
    else
      puts 'Error in sentiment extraction call: ' + response['statusInfo']
    end
  end

  def snippet
    length = 70
    if text.length < length
      text
    else
      "#{text[0..length]}..."
    end
  end

  def get_keywords
    alchemyapi = AlchemyAPI.new
    response = alchemyapi.keywords('text', self.text, { 'sentiment'=>1 })

    if response['status'] == 'OK'
    	keywords = response['keywords']
    else
    	puts 'Error in keyword extraction call: ' + response['statusInfo']
    end
  end

  def keyword_analysis
    alchemyapi = AlchemyAPI.new
    response = alchemyapi.keywords('text', text, 'sentiment' => 1)
    if response['status'] == 'OK'
      keywords = response['keywords']
      keywords.each do |keyword|
        word = Keyword.find_or_create_by(text: keyword["text"])
        keyword["mixed"].nil? ? mixed = false : mixed = true
        relevance = keyword["relevance"]
        sentiment = keyword["sentiment"]["score"]
        DreamsKeyword.create(dream: self, keyword: word, relevance: relevance, sentiment: sentiment, mixed: mixed)
      end
    else
    	puts 'Error in keyword extraction call: ' + response['statusInfo']
    end
  end
end
