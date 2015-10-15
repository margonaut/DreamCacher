# refactoring this file to a PORO in models

# class AnalyticsDashboardSerializer < ActiveModel::Serializer
#   attributes :dreams
#
#   def initialize(dreams)
#     @dreams = dreams
#   end

  # # def self.assemble_data(dreams)
  #
  # def pie_chart
  #   percentages = calculate_sentiment_percentages
  #   data = [{
  #       name: "Positive",
  #       y: percentages["positive"]
  #   }, {
  #       name: "Negative",
  #       y: percentages["negative"],
  #       sliced: true,
  #       selected: true
  #   }, {
  #       name: "Neutral",
  #       y: percentages["neutral"]
  #   }, {
  #       name: "Mixed",
  #       y: percentages["mixed"]
  #   }]
  # end
  #
  # def percentage(number, total)
  #   (number/total) * 100
  # end
  #
  # def calculate_sentiment_percentages
  #   dream_array = @dreams.to_a
  #   total = @dreams.count.to_f
  #   mixed = dream_array.count { |dream| dream.mixed? }
  #   positive = dream_array.count { |dream| dream.positive? }
  #   negative = dream_array.count { |dream| dream.negative? }
  #   neutral = dream_array.count { |dream| dream.neutral? }
  #   result = { positive: percentage(positive.to_f, total),
  #              negative: percentage(negative.to_f, total),
  #              neutral: percentage(neutral.to_f, total),
  #              mixed: percentage(mixed.to_f, total) }
  # end
# end
