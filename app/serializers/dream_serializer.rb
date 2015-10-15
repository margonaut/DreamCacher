class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :title, :text, :sentiment,
             :date, :user, :mixed, :nice_date,
             :keyword_sentiment_count, :good_keywords

  def user
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
    positive = good_keywords.count { |keyword| keyword.positive? }
    negative = good_keywords.count { |keyword| keyword.negative? }
    neg_mixed = good_keywords.count { |keyword| keyword.mixed? && keyword.sentiment.to_f < 0 }
    pos_mixed = good_keywords.count { |keyword| keyword.mixed? && keyword.sentiment.to_f > 0 }
    [-neg_mixed, -negative, pos_mixed, positive]
    # {positive: positive, negative: negative, neg_mixed: neg_mixed, pos_mixed: pos_mixed}
  end

  def mixed?
    if mixed == true
      return true
    else
      return false
    end
  end

  def positive?
    if sentiment.to_f > 0 && !mixed?
      return true
    else
      return false
    end
  end

  def negative?
    if sentiment.to_f < 0 && !mixed?
      return true
    else
      return false
    end
  end

  def neutral?
    if sentiment.to_f == 0 && !mixed?
      return true
    else
      return false
    end
  end
end
