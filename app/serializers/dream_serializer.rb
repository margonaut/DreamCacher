class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :positive?, :title, :text, :sentiment,
             :date, :user_email, :mixed, :nice_date,
             :keyword_sentiment_count, :good_keywords

  def user_email
    object.user.email
  end

  def good_keywords
    object.dreams_keywords.map do |keyword|
      DreamsKeywordSerializer.new(keyword)
    end
  end

  def nice_date
    object.date.strftime("%m/%d/%Y")
  end

  def keyword_sentiment_count
    k = good_keywords
    positive = good_keywords.count { |k| k.positive? }
    negative = good_keywords.count { |k| k.negative? }
    neg_mixed = good_keywords.count { |k| k.mixed? && k.sentiment.to_f < 0 }
    pos_mixed = good_keywords.count { |k| k.mixed? && k.sentiment.to_f > 0 }
    [-neg_mixed, -negative, pos_mixed, positive]
  end

  def positive?
    if sentiment.to_f > 0 && !mixed
      return true
    else
      return false
    end
  end

  def negative?
    if sentiment.to_f < 0 && !mixed
      return true
    else
      return false
    end
  end

  def neutral?
    if sentiment.to_f == 0 && !mixed
      return true
    else
      return false
    end
  end
end
