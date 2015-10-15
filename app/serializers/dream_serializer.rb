class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :title, :text, :sentiment,
             :date, :user, :mixed, :nice_date,
             :keyword_sentiment_count

  def user
    object.user.email
  end

  def nice_date
    object.date.strftime("%m/%d/%Y")
  end

  def keyword_sentiment_count
    positive = dreams_keywords.count { |keyword| keyword.positive? }
    negative = dreams_keywords.count { |keyword| keyword.negative? }
    neg_mixed = dreams_keywords.count { |keyword| keyword.mixed? && keyword.sentiment < 0 }
    pos_mixed = dreams_keywords.count { |keyword| keyword.mixed? && keyword.sentiment > 0 }
    result = {positive: positive, negative: negative, neg_mixed: neg_mixed, pos_mixed: pos_mixed}

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
