class User < ActiveRecord::Base
  has_many :music

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
