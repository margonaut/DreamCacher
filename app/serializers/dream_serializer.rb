class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :title, :text, :sentiment,
             :date, :user, :mixed, :nice_date
             :positivity

  def self.pie_data(dreams)
    data = [{
        name: "Positive",
        y: percentage("positive")
    }, {
        name: "Negative",
        y: 24.03,
        sliced: true,
        selected: true
    }, {
        name: "Neutral",
        y: 10.38
    }, {
        name: "Mixed",
        y: 4.77
    }]
  end

  def user
    object.user.email
  end

  def nice_date
    object.date.strftime("%m/%d/%Y")
  end
end
