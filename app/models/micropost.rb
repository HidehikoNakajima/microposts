class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :retweets, class_name: "Micropost", foreign_key: "baseid", dependent: :destroy
  belongs_to :tweet, class_name: "Micropost", foreign_key: "id"

  has_one :tweeter, class_name: "User", foreign_key: "baseuser_id"
end
