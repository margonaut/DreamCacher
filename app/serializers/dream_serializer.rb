class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :title, :text, :sentiment,
             :date, :user, :mixed, :nice_date

  def user
    object.user.email
  end

  def nice_date
    object.date.strftime("%m/%d/%Y")
  end
end
