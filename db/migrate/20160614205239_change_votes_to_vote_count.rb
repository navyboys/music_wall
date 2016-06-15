class ChangeVotesToVoteCount < ActiveRecord::Migration
  def change
    rename_column :musics, :votes, :vote_count
  end
end
