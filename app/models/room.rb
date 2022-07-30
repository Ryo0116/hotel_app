class Room < ApplicationRecord

  mount_uploader :image_name, ImageUploader

  belongs_to :user

  has_many :reservations

  validates :name, presence: true
  validates :introduce, presence: true
  validates :single_rate, presence: true
  validates :address, presence: true
  validates :image_name, presence: true
  validates :user_id, presence: true


end
