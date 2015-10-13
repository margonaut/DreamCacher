class User < ActiveRecord::Base
  has_many :dreams
  has_many :keywords, through: :dreams
  after_create :first_dream

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def first_dream
    Dream.create(user: self, date: Date.today,
                 sentiment: "0.8", title: "Welcome to your Dream Journal",
                 text: "This is where your dreams are stored! Scroll through your journal
                        timeline to see the details of each dream.")
  end
end
