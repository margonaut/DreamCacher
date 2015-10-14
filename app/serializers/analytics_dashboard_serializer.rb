class AnalyticsDashboardSerializer < ActiveModel::Serializer
  attributes :pie_chart

  def initialize(dreams)
    @dreams = dreams
    binding.pry
  end

  def pie_chart
    percentages = calculate_pie_data
    data = [{
        name: "Positive",
        y: percentages["positive"]
    }, {
        name: "Negative",
        y: percentages["negative"],
        sliced: true,
        selected: true
    }, {
        name: "Neutral",
        y: percentages["neutral"]
    }, {
        name: "Mixed",
        y: percentages["mixed"]
    }]
  end

  def percentage_positivity(type)
    # write a method that uses the 'type' of sentiment
    # and the @current_dreams to find the percentage of which
    #belong to that type

    { positive: num, negative: num, neutral: num, mixed: mixed_num }
  end
end
