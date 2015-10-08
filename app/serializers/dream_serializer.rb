class DreamSerializer < ActiveModel::Serializer
  has_many :dreams_keywords

  attributes :id, :title, :text, :sentiment,
             :date, :user, :mixed

  def user
    object.user.email
  end
end
