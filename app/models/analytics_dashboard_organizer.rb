class AnalyticsDashboardOrganizer
  include ActiveModel::Serialization
  include ActiveModel::Model

  attr_reader :dreams

  def initialize(dreams)
    @dreams = dreams
  end
end
