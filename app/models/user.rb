class User < ActiveRecord::Base
  include BCrypt

  has_many :musics
  has_many :votes
  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def voted?(music)
    self.votes.find_by(music: music) ? true : false
  end

  def reviewed?(music)
    self.reviews.find_by(music: music) ? true : false
  end
end
