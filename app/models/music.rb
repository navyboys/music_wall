class Music < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true
end
