require 'alchemyapi'

class DreamAnalyzer

  def self.analyze_dream(dream)
    alchemyapi = AlchemyAPI.new
    keyword_response = alchemyapi.keywords('text', dream.text, 'sentiment': 1)
    sentiment_response = alchemyapi.sentiment('text', dream.text, 'sentiment': 1)
    if sentiment_response['status'] == 'OK' && keyword_response['status'] == 'OK'
      self.update_sentiment(sentiment_response, dream)
      self.update_keywords(keyword_response, dream)
    else
      puts 'Error in extraction call: ' + keyword_response['statusInfo']
    end
  end

  def self.update_sentiment(response, dream)
    new_sentiment = response['docSentiment']['score']
    dream.update_columns(sentiment: new_sentiment)
  end

  def self.update_keywords(response, dream)
    old_keywords = dream.dreams_keywords
    dream.dreams_keywords.destroy(old_keywords)
    keywords = response['keywords']
    keywords.each do |keyword|
      word = Keyword.find_or_create_by(text: keyword["text"])
      keyword["mixed"].nil? ? mixed = false : mixed = true
      relevance = keyword["relevance"]
      sentiment = keyword["sentiment"]["score"]
      DreamsKeyword.create(dream: dream,
                           keyword: word,
                           relevance: relevance,
                           sentiment: sentiment,
                           mixed: mixed)
    end
  end
end
