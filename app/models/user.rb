class User < ApplicationRecord

  has_many :rooms
  has_many :reservations

  has_one_attached :image_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  validates :name, presence: true #名前記入必須
  validates :introduce, length: { maximum: 140 } #自己紹介１４０文字まで

  mount_uploader :image_name, ImageUploader

  attr_accessor :current_password
end
