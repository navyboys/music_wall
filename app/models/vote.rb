class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :music

  after_save :increment_votes

  private

  def increment_votes
    music.vote_count ||= 0
    music.vote_count += 1 if vote
    music.save
  end
end
