class DreamsKeywordSerializer < ActiveModel::Serializer
  attributes :text, :sentiment, :relevance, :date, :nice_date,
             :mixed, :positive?, :negative?, :neutral?, :mixed?,
             :positivity

  def text
    object.keyword.text
  end

  def date
    object.dream.date
  end

  def nice_date
    object.dream.date.strftime("%m/%d/%Y")
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
