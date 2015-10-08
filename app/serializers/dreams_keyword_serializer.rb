class DreamsKeywordSerializer < ActiveModel::Serializer
  attributes :text, :sentiment, :relevance, :date

  def text
    object.keyword.text
  end

  def date
    object.dream.date
  end
end
