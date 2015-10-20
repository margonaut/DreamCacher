class User < ActiveRecord::Base
  has_many :dreams
  has_many :keywords, through: :dreams
  after_create :first_dream

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def fake_username
    user_info = email.split('@')
    user_info[0]
  end

  def total_keyword_count
    total = 0
    dreams.each do |dream|
      total += dream.keyword_count
    end
    total
  end

  def average_word_count
    total = 0
    dreams.each do |dream|
      total += dream.text.split.count
    end
    average = total/dreams.count
  end

  def average_dream_sentiment
    total = 0
    dreams.each do |dream|
      total += dream.sentiment.to_f
    end
    average = total/dreams.count
    average.round(3)
  end

  private

  def first_dream
    dream = Dream.create(user: self, date: Date.today,
                         sentiment: "0.8", title: "Welcome to your Dream Journal",
                         text: "This is where your dreams are stored! Scroll
                         through your journal timeline to see the
                         details of each dream.")
  end
end
