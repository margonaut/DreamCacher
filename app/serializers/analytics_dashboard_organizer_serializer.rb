class AnalyticsDashboardOrganizerSerializer < ActiveModel::Serializer
  attributes :good_dreams, :dream_dates, :pie_chart, :stacked_bar, :scatter_plot

  def good_dreams
    object.dreams.map do |dream|
      DreamSerializer.new(dream)
    end
  end

  def dream_dates
    dates = []
    good_dreams.each do |dream|
      dates << dream.nice_date
    end
    dates
  end

  def scatter_plot
    data = { positive: [], negative: [], mixed: [],
             positive_keywords: [], negative_keywords: [],
             mixed_keywords: [] }
    good_dreams.each do |dream|
      dream.good_keywords.each do |keyword|
        if keyword.positive?
          data[:positive] << [keyword.relevance.to_f, keyword.sentiment.to_f]
          data[:positive_keywords] << keyword.text
        elsif keyword.negative?
          data[:negative] << [keyword.relevance.to_f, keyword.sentiment.to_f]
          data[:negative_keywords] << keyword.text
        elsif keyword.mixed?
          data[:mixed] << [keyword.relevance.to_f, keyword.sentiment.to_f]
          data[:mixed_keywords] << keyword.text
        end
      end
    end
    data
  end

  def pie_chart
    @_pie_chart_data ||= begin
    [{
          name: "Positive",
          y: positive_result
      }, {
          name: "Negative",
          y: negative_result,
          sliced: true,
          selected: true
      }, {
          name: "Neutral",
          y: neutral_result
      }, {
          name: "Mixed",
          y: mixed_result
      }]
    end
  end

  def stacked_bar
    dates = dream_dates
    keyword_data = [{
        name: 'Negative Mixed',
        data: []
    }, {
        name: 'Negative',
        data: []
    }, {
        name: ' Positive Mixed',
        data: []
    }, {
        name: 'Positive',
        data: []
    }]
    good_dreams.each do |dream|
      count = dream.keyword_sentiment_count
      keyword_data.each_with_index do |sentiment, index|
        sentiment[:data] << count[index]
      end
    end
    { dates: dates, data: keyword_data }
  end

  private

  def percentage(number, total)
    (number/total) * 100
  end

  def positive_result
    percentage(positive_count, total)
  end

  def positive_count
    good_dreams.count { |dream| dream.positive? }.to_f
  end

  def negative_result
    percentage(negative_count, total)
  end

  def negative_count
    good_dreams.count { |dream| dream.negative? }.to_f
  end

  def mixed_result
    percentage(mixed_count, total)
  end

  def mixed_count
    good_dreams.count { |dream| dream.mixed? }.to_f
  end

  def neutral_result
    percentage(neutral_count, total)
  end

  def neutral_count
    good_dreams.count { |dream| dream.neutral? }.to_f
  end

  def total
    good_dreams.count.to_f
  end
end
