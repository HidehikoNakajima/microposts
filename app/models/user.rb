class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  validates :name, presence: true
  validates :name, length: { maximum: 50}, if: ->(u) { u.name.present? }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } , if: ->(u) { u.age.present? }
  validates :area, presence: true, on: :update
  validates :area, length: { maximum: 50}, if: ->(u) { u.area.present? }
  validates :age , presence:true, on: :update
  validates :age , numericality:{greater_than_or_equal_to:0}, if: ->(u) { u.age.present? }
  has_secure_password
  has_many :microposts
  has_many :following_relationships, class_name: "Relationship", 
                                    foreign_key: "follower_id", 
                                    dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  belongs_to :micropost, class_name: "Micropost"
  

  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
end
