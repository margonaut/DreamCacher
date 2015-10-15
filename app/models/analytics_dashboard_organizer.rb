class AnalyticsDashboardOrganizer

  def initialize(dreams)
    @dreams = dreams
    pie_chart_data
  end

  def pie_chart_data
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

  private

  def percentage(number, total)
    (number/total) * 100
  end

  def positive_result
    percentage(positive_count, total)
  end

  def positive_count
    @dreams.to_a.count { |dream| dream.positive? }.to_f
  end

  def negative_result
    percentage(negative_count, total)
  end

  def negative_count
    @dreams.to_a.count { |dream| dream.negative? }.to_f
  end

  def mixed_result
    percentage(mixed_count, total)
  end

  def mixed_count
    @dreams.to_a.count { |dream| dream.mixed? }.to_f
  end

  def neutral_result
    percentage(neutral_count, total)
  end

  def neutral_count
    @dreams.to_a.count { |dream| dream.neutral? }.to_f
  end

  def total
    @dreams.count.to_f
  end
end
