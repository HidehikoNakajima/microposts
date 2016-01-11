class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  validates :name, presence: true
  validates :name, length: { maximum: 50}, if: ->(u) { u.name.present? }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } , if: ->(u) { u.age.present? }
  validates :area, presence: true
  validates :area, length: { maximum: 50}, if: ->(u) { u.area.present? }
  validates :age , presence:true
  validates :age , numericality:{greater_than_or_equal_to:0}, if: ->(u) { u.age.present? }
  has_secure_password
end
