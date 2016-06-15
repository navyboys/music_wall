class ChangeVoteCountDefault < ActiveRecord::Migration
  def change
    change_column_default :musics, :vote_count, 0
  end
end
